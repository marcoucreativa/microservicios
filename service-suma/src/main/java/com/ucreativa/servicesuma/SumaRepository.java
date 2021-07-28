package com.ucreativa.servicesuma;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface SumaRepository extends MongoRepository<Suma, String> {
}
