package com.ucreativa.servicesuma;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

@SpringBootApplication
@RestController
public class ServiceSumaApplication {

	@Autowired
	private SumaRepository repository;

	public static void main(String[] args) {
		SpringApplication.run(ServiceSumaApplication.class, args);
	}

	@GetMapping("/sumas/")
	public List<Suma> getSumas(){
		return repository.findAll();
	}

	@GetMapping("/sumas/{numero1}/mas/{numero2}")
	public String suma(@PathVariable String numero1, @PathVariable String numero2){
		int result = Integer.parseInt(numero1) + Integer.parseInt(numero2);
		FileRepository.salvar(Integer.toString(result), "result/suma.txt");

		this.repository.save(new Suma(new Date(),
				numero1.toString() + " + " + numero2.toString(),
				result));

		return Integer.toString(result);
	}

}
