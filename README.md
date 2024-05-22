# CS548_Extending
CS-548: Cloud-native Software Architectures Computer Science Department • University of Crete. Assignment 4: Extending.

## Part1: 

- Install the custom resource:

  ```kubectl apply -f fruits-crd.yaml```

  we get: 
  ```customresourcedefinition.apiextensions.k8s.io/fruits.hy548.csd.uoc.gr created```

- Create the above instance.

  ```kubectl apply -f fruits.yaml```

  we get:
  
  ```
  fruit.hy548.csd.uoc.gr/apple created
  fruit.hy548.csd.uoc.gr/orange created
  fruit.hy548.csd.uoc.gr/banana created
  ```

- Return the new instance in YAML format.

  ```kubectl get fruit apple -o yaml```
  
    we get:
    ```
    apiVersion: hy548.csd.uoc.gr/v1
    kind: Fruit
    metadata:
      annotations:
        kubectl.kubernetes.io/last-applied-configuration: |
          {"apiVersion":"hy548.csd.uoc.gr/v1","kind":"Fruit","metadata":{"annotations":{},"name":"apple","namespace":"default"},"spec":{"count":3,"grams":980,"origin":"Krousonas"}}
      creationTimestamp: "2024-05-22T11:13:52Z"
      generation: 1
      name: apple
      namespace: default
      resourceVersion: "254065"
      uid: 6f516102-d3ba-41a5-92c1-d9f87ffaf32a
    spec:
      count: 3
      grams: 980
      origin: Krousonas  
    ```
    
- Return a list of all available instances.

  ```kubectl get fruits```
  
  we get:
  
  ```
  NAME     AGE
  apple    34m
  banana   34m
  orange   34m
  ```
