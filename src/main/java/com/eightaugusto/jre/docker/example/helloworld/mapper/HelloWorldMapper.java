package com.eightaugusto.jre.docker.example.helloworld.mapper;

import com.eightaugusto.jre.docker.example.helloworld.dto.HelloWorldDto;
import com.eightaugusto.jre.docker.example.helloworld.entity.HelloWorld;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

/** HelloWorldMapper. */
@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface HelloWorldMapper {

  /**
   * Entity to Dto.
   *
   * @param entity Entity.
   * @return Dto.
   */
  HelloWorldDto convert(HelloWorld entity);
}
