package com.eightaugusto.jre.docker.example.helloworld.service.impl;

import com.eightaugusto.jre.docker.example.helloworld.dto.HelloWorldDto;
import com.eightaugusto.jre.docker.example.helloworld.service.HelloWorldService;
import com.eightaugusto.jre.docker.example.helloworld.service.mapper.HelloWorldMapperTest;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

/** HelloWorldServiceImplTest. */
public class HelloWorldServiceImplTest {

  private static final HelloWorldService service =
      new HelloWorldServiceImpl(HelloWorldMapperTest.MAPPER);

  @Test
  public void when_get_hello_world_expect_not_empty_message() {
    final HelloWorldDto dto = service.getHelloWorld();
    Assertions.assertNotNull(dto.getMessage());
    Assertions.assertFalse(dto.getMessage().isBlank());
  }
}
