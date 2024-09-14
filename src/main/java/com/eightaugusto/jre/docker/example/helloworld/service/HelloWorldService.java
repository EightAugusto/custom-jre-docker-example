package com.eightaugusto.jre.docker.example.helloworld.service;

import com.eightaugusto.jre.docker.example.helloworld.dto.HelloWorldDto;

/** HelloWorldService. */
public interface HelloWorldService {

  /**
   * Get <code>HelloWorldDto</code>.
   *
   * @return HelloWorldDto.
   */
  HelloWorldDto getHelloWorld();
}
