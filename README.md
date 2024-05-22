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

  ## Part2: 
After copying nessecery files from hy548 github repo (controller.py,  greeting-crd.yaml,  hello-world.yaml,  kubeclient.py,  requirements.txt). We can proceed to create the Dokerfile and greeting-controller.yaml.

a) For the dockerfile build and push:

  ```docker build -t thodorisp/greeting-controller:latest .```
  
  ```docker push thodorisp/greeting-controller:latest```

b) For applying greeting-crd and greeting-controller:

  ```
  kubectl apply -f greeting-crd.yaml
  customresourcedefinition.apiextensions.k8s.io/greetings.hy548.csd.uoc.gr created
  
  kubectl apply -f greeting-controller.yaml
  clusterrole.rbac.authorization.k8s.io/greeting-controller-role created
  clusterrolebinding.rbac.authorization.k8s.io/greeting-controller-binding created
  serviceaccount/greeting-controller created
  deployment.apps/greeting-controller created
  ```

To verify we run :

``kubectl get deployments``

we get :

```
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
greeting-controller   1/1     1            1           21m
```

``kubectl get pods -l app=greeting-controller``

we get:

```
NAME                                  READY   STATUS    RESTARTS   AGE
greeting-controller-674597955-rt2br   1/1     Running   0          23m
```

``kubectl logs -l app=greeting-controller``

we get:

```
2024-05-22 18:14:38 INFO check_and_apply: Working in namespace: default
2024-05-22 18:14:38 INFO check_and_apply: Found crd: hello-to-all (message: Hello to all!, replicas: 3)
2024-05-22 18:14:38 INFO check_and_apply: Service already created. Skipping...
2024-05-22 18:14:38 INFO check_and_apply: Found crd: hello-world (message: Hello world!, replicas: 2)
2024-05-22 18:14:38 INFO check_and_apply: Service already created. Skipping...
2024-05-22 18:14:38 INFO check_and_apply: Working in namespace: ingress-nginx
2024-05-22 18:14:38 INFO check_and_apply: Working in namespace: kube-node-lease
2024-05-22 18:14:38 INFO check_and_apply: Working in namespace: kube-public
2024-05-22 18:14:38 INFO check_and_apply: Working in namespace: kube-system
2024-05-22 18:14:38 INFO check_and_apply: Working in namespace: kubernetes-dashboard
```

``kubectl get greetings``

we get:

```
NAME           AGE
hello-to-all   17m
hello-world    17m
```

## Part 3:
After copying nessecery files from hy548 github repo (controller.py, webhook.yaml,  requirements.txt). We can proceed to create the Dokerfile.
For the dockerfile build and push:

  ```docker build -t thodorisp/controller-app:v2 .```
  
  ```docker push thodorisp/controller-app:v2```
  
Update Webhook Configuration:

Update the IP address in the webhook.yaml file to your local IP address.
Replace the image reference with your Docker image in webhook.yaml.
update this part in the webhook.yaml:

  ```
 spec:                         
      containers:
      - image: thodorisp/controller-app:v1 #here
        name: webhook-controller
        env:
        - name: CUSTOM_LABEL
          value: "custom-label"  #here
        ports:
        - containerPort: 8000
```

then apply the webhook:

```kubectl apply -f webhook.yaml```

we get :

```
namespace/custom-label-injector unchanged
issuer.cert-manager.io/issuer-selfsigned created
certificate.cert-manager.io/controller-certificate created
service/controller unchanged
configmap/controller-proxy-config unchanged
deployment.apps/controller unchanged
mutatingwebhookconfiguration.admissionregistration.k8s.io/custom-label-injector configured
```

Create Test Namespace:

``kubectl create namespace test``

Label the "test" namespace to enable the custom-label-injector:

``kubectl label namespace test custom-label-injector=enabled``

create a test yaml file:

```
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
  namespace: test
spec:
  containers:
  - name: nginx
    image: nginx:latest
```

And apply ``kubectl apply -f test.yaml``

You can verify the deployment by running:

``kubectl get deployments -n custom-label-injector``


And to see the pods created by the deployment:

``kubectl get pods -n custom-label-injector``

we get:

```
NAME                          READY   STATUS    RESTARTS   AGE
controller-548699cd59-rj2lw   1/1     Running   0          22m
```

we can see the pods in the test namespace:

``kubectl get pods -A``

