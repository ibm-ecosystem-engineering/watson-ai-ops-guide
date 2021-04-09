# Humio Parser to be setup in Humio

Humio parser can be setup in humio to preprocess the logs.


## 1. Close existing kv parser

<img src="images/parser0.png">


## 2. Update Parser content

```
/(?<ts>\S+)\s(?<mystring>.*)(?<kube>,"kubernetes":*)/ |

@rawstring := mystring
```

<img src="images/parser1.png">


## 3. Set Parser for API token

Set the above created Parser to the API token.

<img src="images/parser2.png">

