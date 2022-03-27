module RegisLib
  module ViewHelpers
    def data_formatada(data)
      data.present? ? data.strftime("%d/%m/%Y") : ''
    end

    def hora_formatada(hora)
      hora.present? ? hora.strftime("%T") : ''
    end

    def moeda(numero)
      numero.present? ? 'R$ ' + number_to_currency(numero, unit: "", separator: ",", delimiter: ".", format: "%n %u") : ""
    end
    
    def presente(valor, var)
      valor.present? ? valor.public_send(var) : ''
    end
  end
end
