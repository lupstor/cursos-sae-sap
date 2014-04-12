class RangeDateValidator < ActiveModel::Validator

  def validate(record)

    if !record.fecha_inicio.nil? and !record.fecha_fin.nil?
      inicio = record.fecha_inicio
      fin = record.fecha_fin
      if inicio > fin
        record.errors[:fecha_inicio] << ": Fecha de inicio no puede ser mayor que fecha de fin"
      end
    end

    if !record.hora_inicio.nil? and !record.hora_fin.nil?
      hora_inicio = record.hora_inicio
      hora_fin = record.hora_fin

      if hora_inicio >= hora_fin
        record.errors[:hora_inicio] << ": Hora de inicio no puede ser mayor ni igual que hora de fin"
      end
    end

    if !record.lunes and !record.martes and !record.miercoles and !record.jueves and !record.viernes and !record.sabado and !record.domingo
      record.errors[:curso] << ": Debe seleccionar por lo menos un dia"
      return
    end

    ##########################################################################################################################
    #Valida traslapes de salon (Esta el salon disponible?)####################################################################
    ##########################################################################################################################

    #CASOS DE TRASLAPE DE HORAS, EL MISMO TIPO DE VALIDACION APLICA PARA LAS FECHAS

    # 1.)       6:10 - 6:50             hora BD
    #    6:00      -        7:00        hora ingresada

    # 2.) 6:00      -           7:00    hora BD
    #          6:10 - 6:50              hora ingresada

    # 3.) 3:00    -    6:40             hora BD
    #           6:10         6:50        hora ingresada

    # 4.)       3:00       -   6:40     hora BD
    #   2:00           6:30             hora ingresada

    if !record.hora_inicio.nil? and !record.hora_fin.nil? and !record.fecha_inicio.nil? and !record.fecha_fin.nil? and !record.salon_id.nil?


      #Obtiene dias seleccionados para agregar al query de verficacion de traslape
      condicion_dias = ""
      condicion_dias = agregar_validacion_dia(condicion_dias, "lunes", record.lunes)
      condicion_dias = agregar_validacion_dia(condicion_dias, "martes", record.martes)
      condicion_dias = agregar_validacion_dia(condicion_dias, "miercoles", record.miercoles)
      condicion_dias = agregar_validacion_dia(condicion_dias, "jueves", record.jueves)
      condicion_dias = agregar_validacion_dia(condicion_dias, "viernes", record.viernes)
      condicion_dias = agregar_validacion_dia(condicion_dias, "sabado", record.sabado)
      condicion_dias = agregar_validacion_dia(condicion_dias, "domingo", record.domingo)

      parametros_de_consulta ={usuario_id: record.usuario_id, curso_id: record.curso_id, salon_id: record.salon_id,
                               fecha_inicio: record.fecha_inicio, fecha_fin: record.fecha_fin, hora_inicio: record.hora_inicio,
                               hora_fin: record.hora_fin, lunes: record.lunes, martes: record.martes, miercoles: record.miercoles,
                               jueves: record.jueves, viernes: record.viernes, sabado: record.sabado, domingo: record.domingo}

      query_traslape =" AND((fecha_inicio >= :fecha_inicio  AND fecha_fin <= :fecha_fin)
                       OR (fecha_inicio <= :fecha_inicio AND fecha_fin >= fecha_fin)
                       OR (fecha_inicio <= :fecha_inicio AND fecha_fin > :fecha_inicio AND fecha_fin <= :fecha_fin)
                       OR  (fecha_inicio >= :fecha_inicio AND fecha_inicio < :fecha_fin AND fecha_fin >= :fecha_fin)
                       )
                       AND ((hora_inicio >= :hora_inicio AND hora_fin <= :hora_fin)
                       OR  (hora_inicio <= :hora_inicio AND hora_fin >= :hora_fin )
                       OR  (hora_inicio <= :hora_inicio AND hora_fin > :hora_inicio AND hora_fin <= :hora_fin )
                       OR  (hora_inicio >= :hora_inicio AND hora_inicio < :hora_fin AND hora_fin >= :hora_fin)
                       )"+(condicion_dias.length > 0 ? "AND ("+ condicion_dias +")" : "")

      tipo_traslape = "salon_id = :salon_id"
      traslapes_salon = Asignacion.where(tipo_traslape +" "+ query_traslape ,parametros_de_consulta)


      cursos_traslapados = "";
      traslapes_salon.each { |key|
        cursos_traslapados = cursos_traslapados + Curso.find(key.curso_id).nombre_curso+ ", "
      }


      if traslapes_salon.count > 0
        record.errors[:salon_id] << ": Asignacion se traslapa con los siguientes cursos: "+ (cursos_traslapados.length > 0 ? cursos_traslapados[0...-2] : "")
        return
      end

      ############################################################################################################################
      #Valida traslapes de profesores en sus propios horarios#####################################################################
      ############################################################################################################################

      tipo_traslape = "usuario_id = :usuario_id"
      traslapes_profesor = Asignacion.where(tipo_traslape +" "+ query_traslape ,parametros_de_consulta)


      cursos_traslapados = "";
      traslapes_profesor.each { |key|
        cursos_traslapados = cursos_traslapados + Curso.find(key.curso_id).nombre_curso+ ", "
      }


      if traslapes_profesor.count > 0
        record.errors[:usuario_id] << ": Al profesor #{Usuario.find(record.usuario_id).nombre} se le traslapan los siguientes cursos en su horario: "+ (cursos_traslapados.length > 0 ? cursos_traslapados[0...-2] : "")
      end


    end
  end

  def agregar_validacion_dia(condicion, nombre_dia, seleccionado)
    if seleccionado
      if condicion.length == 0
        condicion = nombre_dia + " = :" + nombre_dia
      else
        condicion = condicion + " OR " + nombre_dia + " = :" + nombre_dia
      end
    end
    return condicion
  end


end

