class SalonesCrud<Netzke::Basepack::Grid

  def configure(c)
    super
    c.model = "Salon"
    c.viewConfig = {
        stripeRows: true,
        enableTextSelection: true
    }
    c.columns = [
        {name: :nombre_salon, header: "Salon", width: 950}
    ]
  end

  def preconfigure_record_window(c)
    super
    c.width = 400
  end
end