package com.ucreativa.calculadoramonoliticaserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;

@SpringBootApplication
public class CalculadoraMonoliticaServerApplication {

	public static void main(String[] args) {

		int port = 8081;

		try (ServerSocket serverSocket = new ServerSocket(port)){
			while (true){
				Socket socket = serverSocket.accept();
				InputStream inputStream = socket.getInputStream();
				BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
				String mensaje = reader.readLine();
				String[] mensajes = mensaje.split(",");
				System.out.println("Este es el mensaje -> " + mensaje);
				FileRepository.salvar(mensajes[0], mensajes[1]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}


		SpringApplication.run(CalculadoraMonoliticaServerApplication.class, args);
	}

}
