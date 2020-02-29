Feature: A producer for the Demo Order domain

  # The consumer is expecting the key to be an Integer, and the value to be an Order class serialized into JSON.
  #

  Background:

    * def KafkaProducer = Java.type('karate.kafka.KarateKafkaProducer')
    * def topic = 'order-input'

  Scenario: Produce an Order ...

    * def kp = new KafkaProducer()
    * def key = 45678
    * def value =
    """
    {
      id : 234,
      customer : {
        firstName : "John",
        lastName  : "Smith",
        contact   : {
            email : "john@gmail.com",
            phone : "619-123-4567"
         }
      },
      lineItems :
        [
          { id: 12345, quantity: 3, price: 10 },
          { id: 67890, quantity: 2, price: 7 }
        ]
    }
    """
    * kp.send(topic, key, value)
    * kp.close()
