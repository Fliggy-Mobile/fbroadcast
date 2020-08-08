<p align="center">
  <a href="https://github.com/Fliggy-Mobile">
    <img width="200" src="https://gw.alicdn.com/tfs/TB1a288sxD1gK0jSZFKXXcJrVXa-360-360.png">
  </a>
</p>

<h1 align="center">fbroadcast</h1>


<div align="center">

<p>将复杂简单化，且易于管理。</p>

<p>FBroadcast 帮助开发者在应用内建立一套高效的广播系统，支持粘性广播。</p>

<p><strong>主理人：<a href="">CoorChice</a>(<a href="coorchice.cb@alibaba-inc.com">coorchice.cb@alibaba-inc.com</a>)</strong></p>

<p>

<a href="https://pub.dev/packages/fbroadcast#-readme-tab-">
    <img height="20" src="https://img.shields.io/badge/Version-1.0.0-important.svg">
</a>


<a href="https://github.com/Fliggy-Mobile/fbroadcast">
    <img height="20" src="https://img.shields.io/badge/Build-passing-brightgreen.svg">
</a>


<a href="https://github.com/Fliggy-Mobile">
    <img height="20" src="https://img.shields.io/badge/Team-FAT-ffc900.svg">
</a>

<a href="https://www.dartcn.com/">
    <img height="20" src="https://img.shields.io/badge/Language-Dart-blue.svg">
</a>

<a href="https://pub.dev/documentation/fbroadcast/latest/fbroadcast/fbroadcast-library.html">
    <img height="20" src="https://img.shields.io/badge/API-done-yellowgreen.svg">
</a>

<a href="http://www.apache.org/licenses/LICENSE-2.0.txt">
   <img height="20" src="https://img.shields.io/badge/License-Apache--2.0-blueviolet.svg">
</a>

<p>
<p>

</div>

![](https://gw.alicdn.com/tfs/TB1fsXYij39YK4jSZPcXXXrUFXa-1024-602.png)

**[English](https://github.com/Fliggy-Mobile/fbroadcast) | 简体中文**

> 感觉还不错？请投出您的 **Star** 吧 🥰 ！

# ✨ 特性

来看看 **FBroadcast** 为开发者提供了那些不可思议的能力支持：

- 支持**发送**和**接收**指定类型的消息

- 消息支持携带**任意类型**数据包

- 提供**环境注册**，一行代码即可移除环境内所有接收者

- 不可思议的**粘性广播**

# 🛠 使用指南

**FBroadcast** 是一套高效灵活的**广播系统**，可以帮助开发者**轻松、有序**的构建具有极具复杂性的**关联交互**和**状态变化**的精美应用。


![](https://gw.alicdn.com/tfs/TB1xVcSe9R26e4jSZFEXXbwuXXa-1456-528.png)


**FBroadcast** 将为构建复杂的精美应用带来那些显而易见的改变呢？

- **Widget/模块间的完全解耦**  
 
    通过 **FBroadcast** 高效的广播系统，开发者可以轻易的完成**Widget/模块**的解耦。在应用构建的时候，经常需要 **Widget/模块A、B、C、..** 之间根据交互操作互相变更状态或数据，开发者们不得不为此让各个**Widget/模块互相依赖**或者为它们建立**统一的状态管理**，这能解决问题，但这让构建变得麻烦，也让变更变得难以进行。
    
    **FBroadcast** 通过建立起**简单、有效、明确**广播系统，使得在任意**Widget/模块**中**任意时刻/位置**的改变能够主动发出广播，而需要根据这些变更作出**响应或更新视图**的**Widget/模块**只需要注册相应的**信息接收器**，就可以在变更发生时，接收到消息，作出响应。这使得关联模块间不再需要互相依赖，或是为它们设计建立统一的状态管理器。
    
    **十分简单，轻量，和易于变更**。当一个**Widget/模块**不在需要根据另一个**Widget/模块**的变更而更新时，只需移除其中的**接收器**即可，而不用为此而大改**依赖关系**或是**状态管理器**。


- **简单、灵活、明确、易管理**  

    **FBroadcast**  为开发者提供了可以在任意时刻发送广播，和注册/移除接收器的能力，毫无约束和灵活。
    
    广播和接收器之间通过明确的类型（字符串）来互相确认身份，指定类型的广播，只能被指定类型的接收器接收。
    
    **FBroadcast** 提供了环境注册支持，开发者可以在环境解构时，通过 [unregister()] 函数一次性移除环境中的所有类型接收器，而无需记忆和关心究竟需要移除那些接收器。例如，开发者可以在 **Widget** 的 `dispose()` 中，将注册在该 **Widget** 中的所有接收器一次性全部移除。
    
    借助现代**IDEA**的能力，开发者可以为广播系统建立一张（或多张）统一的广播类型索引表，通过**IDEA**的**引用索引**，开发者可以轻松的、一目了然的看到该类型的广播在那些地方被发送过，在那些地方注册了接收器，十分易于管理和维护。而使用字符串来作为类型标识，使得开发者可以将不同类型的广播含义描述的足够清晰明白。
    

- **粘性广播支持**
    
    **FBroadcast** 提供了发送**粘性广播**的支持。在还没有注册任何接收器的情况下，开发者可以在事件发生时，预先发送一条**粘性广播**。**粘性广播**会被暂时滞留在广播系统中，当有接收器被注册时，即会立即广播。这有助于帮助开发者在做逻辑设计时采取更清晰有效的思路。
    
    例如，当一个控制模块中的开关按钮被打开，而此时开关所控制的模块还没有被构建，就可以先发送一条**粘性广播**，在模块被构建完成注册了接收器后，就会立即接收到**粘性广播**而进入开启状态（这与互相依赖、定义统一状态管理或是参数传递，然后检查开关状态的思路有本质区别）。

## 普通广播

通过 **FBroadcast** 来注册，发送广播非常简便。

```dart
/// 注册接收器
/// 
/// register
FBroadcast.instance().register(Key_Message, (value) {
  /// do something
});

/// 发送消息
/// 
/// send message
FBroadcast.instance().broadcast(Key_Message);
```

**FBroadcast** 允许开发者在发送消息的时候，带有数据。

```dart
/// 注册接收器
/// 
/// register
FBroadcast.instance().register(Key_Message, (value) {
  /// 获取数据
  /// 
  /// get data
  var data = value;
});

/// 发送消息和数据
/// 
/// send message and data
FBroadcast.instance().broadcast(
  /// 消息类型
  /// 
  /// message type
  Key_Message, 

  /// 数据
  /// 
  /// data
  value: data,
);
```

开发者可以选择将特定类型的消息进行持久化，这样就能轻易实现广播式的全局状态管理。

```dart
FBroadcast.instance().broadcast(
  /// 消息类型
  /// 
  /// message type
  Key_Message, 

  /// 数据
  /// 
  /// data
  value: data, 

  /// 将消息类型持久化
  /// 
  /// Persist the message types
  persistence: true,
);
```

当开发者将一个消息类型持久化后，就可以在任意位置，通过 `FBroadcast.instance().value(String key)` 来获取广播系统中该类型消息的最新的数据。而更新广播系统中的数据只需要通过 `broadcast()` 即可完成。

> ⚠️注意，一个消息类型一旦持久化就只能通过 `FBroadcast.instance().clear(String key)` 来从广播系统中移除该类型的消息。


## 粘性广播

**FBroadcast** 支持开发者发送**粘性广播**。

```dart
FBroadcast.instance().stickyBroadcast(
  /// 消息类型
  /// 
  /// message type
  Key_Message, 

  /// 数据
  /// 
  /// data
  value: data, 
);
```

当广播系统中没有对应类型的接收器时，**粘性广播** 将会暂时滞留在系统中，直到有该类型的接收器被注册，则会立即发出广播（当广播系统中有对应类型的接收器时，就和普通广播具有相同的表现）。

## 环境注册

**FBroadcast** 支持在注册接收器时传入一个**环境对象（可以是任意类型）**，这会将接收器注册到环境中，当环境解构时，开发者可以方便的一次性移除所有在该环境中注册的接收器。

```dart
/// 注册接收器
/// 
/// register
FBroadcast.instance().register(
  /// 消息类型
  /// 
  /// Message type
  Key_Message1,

  /// Receiver
  ///
  /// Receiver
  (value) {
    /// do something
  },

  /// 更多接收器
  /// 
  /// more receiver
  more: {
    /// 消息类型： 接收器
    /// 
    /// Message type: Receiver
    Key_Message2: (value) {
      /// do something
    },
    Key_Message3: (value) {
      /// do something
    },
    Key_Message4: (value) {
      /// do something
    },
  },

  /// 环境对象
  /// 
  /// context
  context: this,
);

/// 移除环境中的所有接收器
/// 
/// Remove all receivers from the environment
FBroadcast.instance().unregister(this);
```

## Api 说明

### 注册接收者

```dart
/// 注册指定类型的接收者。
/// 如果传入了 [context] 环境，该接收者将会被注册到环境中。环境可以是任意类型的对象，例如：页面、类..
/// 接收者通过 [value] 可以获取到本条消息携带的数据。
/// 当调用 [unregister] 时，该接收者即会被清除。
/// [key] - 消息类型
/// [receiver] - 接收者
/// [context] - 环境。不为null，[receiver] 将会被注册到环境中。
/// [more] - 方便一次注册多个接收者
///
/// Register recipients of the specified type.
/// If the [context] environment is passed in, the recipient will be registered in the environment. The environment can be any type of object, for example: page, class...
/// The receiver can get the data carried in this message through [value].
/// When [unregister] is called, the receiver will be cleared.
/// [key]-message type
/// [receiver] - receiver
/// [context] - context. Not null, [receiver] will be registered in the environment.
/// [more] - Make it easy to register multiple recipients at once
FBroadcast register(String key, ValueCallback receiver, {Object context, Map<String, ValueCallback> more})
```

### 发送广播

#### 普通广播

```dart
/// 广播一条 [key] 类型的消息。
/// 已经注册在系统中的接收者将会接收到本条消息。
/// 接收者通过 [value] 可以获取到本条消息携带的数据。
/// [key] - 消息类型
/// [value] - 消息携带的数据。可以是任意类型或是null。
/// [persistence] - 是否持久化消息类型。持久化的消息可以在任意时刻通过 [FBroadcast.value] 获取当前消息的数据包。默认情况下，未持久化的消息类型在没有接收者的时候会被移除，而持久化的消息类型则不会。开发者可以通过 [clear] 函数来移除持久化的消息类型。
///
/// Broadcast a message of type [key].
/// Recipients already registered in the system will receive this message.
/// The receiver can get the data carried in this message through [value].
/// [key] - Message type
/// [value] - The data carried in the message. Can be any type or null.
/// [persistence] - Whether or not to persist message types. Persistent messages can be retrieved at any time by [FBroadcast. Value] for the current message packet. By default, unpersisted message types are removed without a receiver, while persisted message types are not. Developers can use the [clear] function to remove persistent message types.
void broadcast(String key, {dynamic value, bool persistence})
```

#### 发送粘性广播

```dart
/// 广播一条 [key] 类型的粘性消息。
/// 如果广播系统中还有没注册该类型的接收者，本条消息将被滞留在系统中。一旦有该类型接收者被注册，本条消息将会被立即发送给接收者。
/// 如果系统中已经注册有该类型的接收者，本条消息将会被立即发送给接收者。
/// 接收者通过 [value] 可以获取到本条消息携带的数据。
/// [key] - 消息类型
/// [value] - 消息携带的数据。可以是任意类型或是null。
/// [persistence] - 是否持久化消息类型。持久化的消息可以在任意时刻通过 [FBroadcast.value] 获取当前消息的数据包。默认情况下，未持久化的消息类型在没有接收者的时候会被移除，而持久化的消息类型则不会。开发者可以通过 [clear] 函数来移除持久化的消息类型。
///
/// Broadcast a sticky message of type [key].
/// If there are unregistered receivers of this type in the broadcast system, this message will be stuck in the system. Once a recipient of this type is registered, this message will be sent to the recipient immediately.
/// If this type of receiver is already registered in the system, this message will be sent to the receiver immediately.
/// The receiver can get the data carried in this message through [value].
///
/// [key] - Message type
/// [value] - The data carried in the message. Can be any type or null.
/// [persistence] - Whether or not to persist message types. Persistent messages can be retrieved at any time by [FBroadcast. Value] for the current message packet. By default, unpersisted message types are removed without a receiver, while persisted message types are not. Developers can use the [clear] function to remove persistent message types.
void stickyBroadcast(String key, {dynamic value, bool persistence})
```

### 获取指定消息的数据包

```dart
/// 接收者可以通过该函数获取消息中的数据
///
/// This function allows the receiver to get the data in the message
dynamic value(String key)
```

### 移除指定接收者

```dart
/// 移除指定的接收者 [receiver]。
/// 如果指定了 [key]、[context] 将有助于更快的移除指定接收者。
/// [receiver] - 接收者
/// [key] - 消息类型
/// [context] - 环境。
///
/// Remove the specified receiver [receiver].
/// If [key] and [context] are specified, it will help to remove the specified recipient faster.
/// [receiver] - receiver
/// [key]-message type
/// [context] - context.
FBroadcast remove(ValueCallback receiver, {String key, Object context})
```

### 移除指定类型消息

```dart
/// 移除广播系统中的指定 [key] 类型的所有接收者，以及该类型的粘性广播。
/// [key] - 类型
///
/// Remove all receivers of the specified [key] type in the broadcast system and sticky broadcasts of that type.
///  [key] - type
void clear(String key)
```


### 移除环境内所有接收者

```dart
/// 移除广播系统中，注册到 [context] 环境内的所有接收者。
/// 例如，在页面关闭时，开发者可以通过 [unregister] 一次性移除注册到该环境内的所有接收者。
/// 当然，前提时在接收者通过 [register] 注册的时候，传入 [context]，将接收者注册到该环境中。
/// [context] - 环境。
///
/// Remove all receivers registered in the [context] environment from the broadcast system.
/// For example, when the page is closed, the developer can use [unregister] to remove all recipients registered in the environment at once.
/// Of course, the prerequisite is that when the receiver registers through [register], pass in [context] to register the receiver to the environment.
/// [context] - context.
void unregister(Object context)
```


### 释放广播系统

```dart
/// 会移除广播系统中的所有的接收者，以及粘性广播。
///
/// Remove all receivers in the broadcasting system, and sticky broadcasting.
void dispose()
```

# 😃 如何使用？

在项目 `pubspec.yaml` 文件中添加依赖：

## 🌐 pub 依赖方式

```
dependencies:
  fbroadcast: ^<版本号>
```

> ⚠️ 注意，请到 [**pub**](https://pub.dev/packages/fbroadcast) 获取 **FBroadcast** 最新版本号

## 🖥 git 依赖方式

```
dependencies:
  fbroadcast:
    git:
      url: 'git@github.com:Fliggy-Mobile/fbroadcast.git'
      ref: '<分支号 或 tag>'
```


> ⚠️ 注意，分支号 或 tag 请以 [**FBroadcast**](https://github.com/Fliggy-Mobile/fbroadcast) 官方项目为准。


# 💡 License

```
Copyright 2020-present Fliggy Android Team <alitrip_android@list.alibaba-inc.com>.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at following link.

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```


### 感觉还不错？请投出您的 [**Star**](https://github.com/Fliggy-Mobile/fbroadcast) 吧 🥰 ！


---

# 如何运行 Demo 工程？

1.**clone** 工程到本地

2.进入工程 `example` 目录，运行以下命令

```
flutter create .
```

3.运行 `example` 中的 Demo



