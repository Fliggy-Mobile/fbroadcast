<p align="center">
  <a href="https://github.com/Fliggy-Mobile">
    <img width="200" src="https://gw.alicdn.com/tfs/TB1a288sxD1gK0jSZFKXXcJrVXa-360-360.png">
  </a>
</p>

<h1 align="center">fbroadcast</h1>


<div align="center">

<p>将复杂简单化，且易于管理。</p>

<p>**FBroadcast** 帮助开发者在应用内建立一套高效的广播系统，支持粘性广播。</p>

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

![](https://gw.alicdn.com/tfs/TB1CdJ5ffzO3e4jSZFxXXaP_FXa-1466-562.png)

**[English](https://github.com/Fliggy-Mobile/fbroadcast) | 简体中文**

> 感觉还不错？请投出您的 **Star** 吧 🥰 ！

# ✨ 特性

来看看 **FBroadcast** 为开发者提供了那些不可思议的能力支持：

- 支持发送和接收指定类型的消息

- 消息支持携带任意类型数据包

- 提供环境注册，一行代码即可移除环境内所有接收者

- 不可思议的粘性广播

# 🛠 使用指南

**FBroadcast** 是一套高效灵活的**广播系统**，可以帮助开发者**轻松、有序**的构建具有极具复杂性的**关联交互**和**状态变化**的精美应用。

## 函数说明

### 注册接收者

```dart
/// 注册指定类型的接收者。
/// 如果传入了 [context] 环境，该接收者将会被注册到环境中。环境可以是任意类型的对象，例如：页面、类..
/// 接收者通过 [value] 可以获取到本条消息携带的数据。
/// 当调用 [unregister] 时，该接收者即会被清除。
/// [key] - 消息类型
/// [receiver] - 接收者
/// [context] - 环境。不为null，[receiver] 将会被注册到环境中。
///
/// Register recipients of the specified type.
/// If the [context] environment is passed in, the recipient will be registered in the environment. The environment can be any type of object, for example: page, class...
/// The receiver can get the data carried in this message through [value].
/// When [unregister] is called, the receiver will be cleared.
/// [key]-message type
/// [receiver] - receiver
/// [context] - context. Not null, [receiver] will be registered in the environment.
FBroadcast register(String key, VoidCallback receiver, {Object context})
```

### 发送广播

#### 普通广播

```dart
/// 广播一条 [key] 类型的消息。
/// 已经注册在系统中的接收者将会接收到本条消息。
/// 接收者通过 [value] 可以获取到本条消息携带的数据。
/// [key] - 消息类型
/// [value] - 消息携带的数据。可以是任意类型或是null。
///
/// Broadcast a message of type [key].
/// Recipients already registered in the system will receive this message.
/// The receiver can get the data carried in this message through [value].
/// [key] - Message type
/// [value] - The data carried in the message. Can be any type or null.
void broadcast(String key, [dynamic value])
```

#### 粘性广播

```dart
/// 广播一条 [key] 类型的粘性消息。
/// 如果广播系统中还有没注册该类型的接收者，本条消息将被滞留在系统中。一旦有该类型接收者被注册，本条消息将会被立即发送给接收者。
/// 如果系统中已经注册有该类型的接收者，本条消息将会被立即发送给接收者。
/// 接收者通过 [value] 可以获取到本条消息携带的数据。
/// [key] - 消息类型
/// [value] - 消息携带的数据。可以是任意类型或是null。
///
/// Broadcast a sticky message of type [key].
/// If there are unregistered receivers of this type in the broadcast system, this message will be stuck in the system. Once a recipient of this type is registered, this message will be sent to the recipient immediately.
/// If this type of receiver is already registered in the system, this message will be sent to the receiver immediately.
/// The receiver can get the data carried in this message through [value].
///
/// [key] - Message type
/// [value] - The data carried in the message. Can be any type or null.
void stickyBroadcast(String key, [dynamic value])
```



## 事件广播


## 粘性广播


## 环境注册




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



