package com.testing;

import static com.testing.HelloWorldController.MESSAGE_KEY;
import static org.assertj.core.api.Assertions.assertThat;

import java.net.UnknownHostException;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class HelloWorldControllerTest {

    @InjectMocks
    private HelloWorldController controller;

    @Test
    void responseShouldContainHelloWorldKey() throws UnknownHostException {
        Map<String, String> result = controller.helloWorld();

        assertThat(result).containsKey(MESSAGE_KEY);
    }
}
