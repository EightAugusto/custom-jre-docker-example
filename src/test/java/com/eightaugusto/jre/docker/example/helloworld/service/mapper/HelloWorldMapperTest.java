package com.eightaugusto.jre.docker.example.helloworld.service.mapper;

import com.eightaugusto.jre.docker.example.helloworld.dto.HelloWorldDto;
import com.eightaugusto.jre.docker.example.helloworld.entity.HelloWorld;
import com.eightaugusto.jre.docker.example.helloworld.mapper.HelloWorldMapper;
import com.eightaugusto.jre.docker.example.helloworld.mapper.HelloWorldMapperImpl;
import java.util.UUID;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

/** HelloWorldMapperTest. */
public class HelloWorldMapperTest {

  public static final HelloWorldMapper MAPPER = new HelloWorldMapperImpl();

  @Test
  public void when_map_hello_world_entity_expect_mapped_dto() {
    final String message = UUID.randomUUID().toString();
    final HelloWorldDto dto = MAPPER.convert(new HelloWorld(message));
    Assertions.assertEquals(message, dto.getMessage());
  }
}
