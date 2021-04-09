## 1.1.1

- Optimize the efficiency of removing broadcast system instances

## 1.1.0

- The 'printfbroadcastinfo()' function is provided to query the broadcast information in the current system to help developers clean up useless broadcasts in time

- Avoid error callback calls in two-way communication

- `FBroadcast.instance({dynamic context})` supports the incoming scope [context], and developers will be able to obtain a broadcasting system that is only valid within the scope.

- Support asynchronous registration by `FBroadcast.unregister(context, async: true)`

## 1.0.2

- StickyBroadcast supports multiple messages of the same type in the broadcast system at the same time


## 1.0.1

- Fix stickyBroadcast pass value is null


## 1.0.0

- the first version
