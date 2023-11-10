# ``StepKit``

Create and manage step drived flows with ease.

## Overview

StepKit provides models and views for creating and managing step drived flows rich of contents. If you need to represent a tutorial or a recipe drived by steps, StepKit is what you need.

## Main components

Struct | Description
--- | ---
``Step``            | Model that represent the main properties of a step.
``StepView``        | Struct that represent the UI of a specific step.
``StepFlowView``    | Struct that represent the UI of a set of steps, called also ***flow***.

### Step
With StepKit you are able to express a flow by specifying an array of steps described with the ``Step`` model object.


``Step`` model allow you to specify ``Step/title``, ``Step/subtitle``, ``Step/description`` and ``Step/action`` that represent a specific step. It also conforms to Codable protocol, this means that you can automatically parse a ``Step`` object or an array of steps by providing to a JSONDecoder object the Data of a JSON string.

The property ``Step/action`` allow you to customize the behavior that drives to the next step. By default ``Step/action`` is setted to value ``StepAction/button(title:)`` that shown a button titled **Next**. 

You can customize ``Step/action`` by providing one of ``StepAction`` enum case.

StepAction | Description
--- | ---
``StepAction/button(title:)``               | Represent a plain button with specified title. Default title setted to **Next**.
``StepAction/checkBox(title:)``             | Represent a single checkbox element with specified title. Default title setted to **Mark as completed**.
``StepAction/checkBoxGroup(items:)``        | Represent a cluster of checkbox elements. The `items` property accept an array of string. Each element of the array will be rendered as single checkbox element.
``StepAction/timer(seconds:notification:)`` | Represent a count down timer. Time is specified in seconds using a TimeInterval object. You can attatch a local notification that it's fired at the end of the count down by populating `notification` property using ``TimerNotification`` model.
``StepAction/stepper(total:title:)``        | Represent a stepper component with specified amount of repetition and title. Default title setted to **Repetitions**.


### StepFlowView


## Topics

### Essentials

