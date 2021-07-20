package com.ucreativa.servicesuma;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ServiceSumaApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServiceSumaApplication.class, args);
	}

	@GetMapping("/suma/{numero1}/mas/{numero2}")
	public String suma(@PathVariable String numero1, @PathVariable String numero2){
		int result = Integer.parseInt(numero1) + Integer.parseInt(numero2);
		return Integer.toString(result);
	}

}
