# Express a Step using JSON syntax

Main concepts on how to use JSON syntax to populate a StepFlowView object.

## Overview

``StepFlowView`` is the view that represent a set of steps. It can be initialized by passing an array of ``Step`` objects or by providing the encoded Data object of a JSON string. 

Initialize ``StepFlowView`` using a JSON string is useful if you want to present a flow view with data fetched from a web server.

Let's see how it works.

### Step model
The main actor that represent a single step it is ``Step`` object. It provides the main properties that describe a specific step, such ``Step/title``, ``Step/subtitle``, ``Step/description`` and ``Step/action``, a special `enum` that describe the behaviour for 'Next step' action.

``Step`` struct conforms to Codable protocol so it can be represented using JSON syntax.

Let's see an example of JSON syntax:

``` json
{
  "title": "Milk and yeast",
  "description": "Heat the milk until it is warm but not hot, about...",
  "action": {
    "timer": {
      "seconds": 300,
      "notification": {
        "title": "Milk and yeast completed",
        "subtitle": "Let's jump to the next step"
      }
    }
  }
}
```
From the provided JSON syntax you can get a ``Step`` object by using a JSONDecoder object using the Data representation of the JSON string. 

```swift
do {
    let step = try JSONDecoder().decode(Step.self, from: jsonData)
} catch {
    // Handle error...
}
```

Finally once you get the ``Step`` object the ``StepView`` object can finelly be created.
```swift
let stepView = StepView(model: step)
```

![Representation of a StepView that expose properties: title, description and action of type timer.](StepView.png)


### StepFlowView and JSON 
Creation of each ``Step`` can be omitted by passing to ``StepFlowView`` a JSON syntax that represent an array of ``Step`` objects. Let's see an example by making some Doughnuts. 

Here is a basic JSON structure that represent the steps of a recipe.

```json
[
  {
    "title": "Milk and yeast",
    "description": "Heat the milk until it is warm but not hot, about...",
    "action": {
      "timer": {
        "seconds": 300,
        "notification": {
          "title": "Milk and yeast completed",
          "subtitle": "Let's jump to the next step"
        }
      }
    }
  },
  {
    "title": "Beat and combine",
    "description": "Using an electric mixer, beat the eggs, butter, sugar and salt into the yeast mixture. Add half of the...",
    "action": {
      "button": {
        "title": "Next"
      }
    }
  },
  {
    "title": "Transfer the dough and cover",
    "description": "Transfer the dough to the bowl, and cover. Let rise at room temperature until it doubles in size, about 1 hour.",
    "action": {
      "timer": {
        "seconds": 3600,
        "notification": {
          "title": "It's time to shape your Doughnuts!",
          "subtitle": "Let's jump to the next step"
        }
      }
    }
  }
]
```

In order to instantiate ``StepFlowView`` you need to get the Data object that represent the recipe JSON string.

```swift
let jsonString = "[{...}, {...}, {...}]"

do {
    let jsonData = try jsonString.data(using: .utf8)
} catch {
    // Handle errors...
}
```


Finally using the jsonData object you can instantiate ``StepFlowView`` object.
```swift
let jsonString = "[{...}, {...}, {...}]"

do {
    let jsonData = try jsonString.data(using: .utf8)

    let stepFlowView = try StepFlowView(data: jsonData)
} catch {
    // Handle errors...
}
```

- Note: Method `StepFlowView(data:)` can throws an error if the JSON string with which Data object is created contains syntax errors. For more information about thrownable errors refer to ``StepKitError`` enum.


## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
