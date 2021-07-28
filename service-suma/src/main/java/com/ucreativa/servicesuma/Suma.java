package com.ucreativa.servicesuma;

import java.util.Date;
import org.springframework.data.annotation.Id;

public class Suma {

    @Id
    public String id;
    public Date fecha;
    public String operacion;
    public int resultado;

    public Suma(){}
    public Suma(Date fecha, String operacion, int resultado){
        this.fecha = fecha;
        this.operacion = operacion;
        this.resultado = resultado;
    }

    @Override
    public String toString() {
        return String.format(
                "SumaResultado[id=%s, fecha='%s', operacion='%s', resultado='%s']",
                id, fecha, operacion, resultado);
    }

}
