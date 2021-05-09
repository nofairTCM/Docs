---
title: and, or 그리고 삼항연산자
---

> 부제 : if 를 대신하는 연산자들  
> 작성 : Qwreey | 최근 수정 : 2021 1/11 5:10  
---

주요 목차 :
 - [and 은 무엇인가](#what_is_and)
 - [or 은 무엇인가](#what_is_or)
 - [삼항 연산자는 무엇인가](#a_and_b_or_c)
 - [연속된 논리 연산자들을 읽어보자](#chain_and_or)

---
### and 란? <a name="what_is_and"></a>
and 는 중요한 논리 연산자중 하나로써 lua 에서는 if 만큼이나 많이 쓰이는 연산자 입니다 

and 는 앞에 값과 뒤에 값을 주었을 때, 두 값이 모두 nil,false<sup>[[참조1](#footnote_1)]</sup> 이 아니라면 뒤에값을 반환합니다 그렇지 않으면 nil 또는 false 을 반환합니다 

이 예제를 실행하여 테스트 해볼 수 있습니다
```lua
print(true and 5) -- 5
print(1 and true) -- true
print(0 and true) -- true (0 도 true 취급)
print(true and "Hello world") -- 'Hello world'
print({} and true) -- true 

-- false(nil,false) 을 반환하는것들
print(nil and false) -- nil (앞에꺼)
print(false and false) -- false (앞에꺼)
print(false and nil) -- false (앞에꺼)
print(false and 1) -- false
print(1 and nil) -- nil
print(1 and false) -- false
```
<!-- 접을 수 있는 라벨 -->
<details>
<summary>출력(output) > </summary>
<div markdown="1">

> Info : Lua 5.3.5<br/>
> 5<br/>
> true<br/>
> true<br/>
> Hello world<br/>
> true<br/>
> nil<br/>
> false<br/>
> false<br/>
> false<br/>
> nil<br/>
> false<br/>

</div>
</details>

and 는 이러한 특성상 if 를 합쳐지도록 만들 수 있습니다
```lua
if (조건문) and (조건문) and (조건문) ... then
```
다음과 같이 and 로 무수히 많은 조건문을 합칠 수 있습니다
이 방법은 if 를 여러번 사용하는것 보다 더 깔끔하기에 많이 사용됩니다
```lua
local Apple = {
   type = "fruit";
   from = "earth";
   cost = nil;
} 

-- and 로 합치지 않은 조건문
if Apple.type == "fruit" then
   if Apple.from == "earth" then
      print("이 사과는 지구에서 온 과일이다")
   end
end 

-- and 로 합친 조건문
if Apple.type == "fruit" and Apple.from == "earth" then
   print("이 사과는 지구에서 온 과일이다")
end
```
<!-- 접을 수 있는 라벨 -->
<details>
<summary>출력(output) > </summary>
<div markdown="1">

> Info : Lua 5.3.5<br/>
> 이 사과는 지구에서 온 과일이다<br/>
> 이 사과는 지구에서 온 과일이다<br/>

</div>
</details>

이외에도 and 는 앞 값이 nil,false<sup>[[참조1](#footnote_1)]</sup> 이라면 뒤에 값은 아에 접근조차 하지 않는다는 특성이 있어 `Item.Text.Color` 와 같은 코드가 있을 때 `Item.Text` 의 존재 여부와는 상관 없이, 오류를 내지 않고 `Color` 를 가져오는 가장 간단한/빠른 방법으로도 사용 할 수 있습니다
```lua
local Item = {
   Text = {
      Color = {238, 110, 255};
   };
}

-- and 를 사용, 2줄(Text 를 변수로 하는 이유는 최적화적인 이유입니다)
local Text = Item.Text
local Color1 = Text and Text.Color

-- if 를 사용, 더 길며 탭라인으로 지저분합니다, 덜 명확함
local Text = Item.Text
local Color2
if Text then
   Color2 = Text.Color
end

-- 두 결과가 같으며 그 값이 Item.Text.Color 임을 증명합니다
print(Color1 == Color2 and Color1 == Item.Text.Color) -- true

-- 오류가 나는지 확인하기 위해 Text 를 없엠
local Item = {}

-- Text 값이 앖어 그냥 nil 를 프린트함
-- 하지만 오류가 난 것은 아닙니다
local Text = Item.Text
local Color = Text and Text.Color
print(Color) -- nil

-- nil(Item.Text) 에 Color 를 얻어오기 시도함
-- 오류가 나며 여기서 코드가 멈춥니다
print(Item.Text.Color) -- error

-- 위의 오류가 코드를 멈춰 이 코드는 실행되지 않습니다
print("코드 끝")
```
<!-- 접을 수 있는 라벨 -->
<details>
<summary>출력(output) > </summary>
<div markdown="1">

> Info : Lua 5.3.5<br/>
> true<br/>
> nil<br/>
> lua5.3: source_file.lua:37: attempt to index a nil value (field 'Text')<br/>
> stack traceback:<br/>
> 	source_file.lua:37: in main chunk<br/>
> 	[C]: in ?<br/>

</div>
</details>

---
### or 이란? <a name="what_is_or"></a>
or 도 and 와 마찬가지로 논리 연산자중 하나로써 lua 에서 많이 사용되는 연산자 입니다 

or 은 뒤에 있는 값과는 상관 없이 앞에 있는 값이 nil,false<sup>[[참조1](#footnote_1)]</sup> 이 아니라면 앞에 있는 값을 반환하고 그렇지 않다면 뒤에 있는 값을 반환합니다 

이 예제를 실행하여 테스트 해볼 수 있습니다
```lua
print(1 or true) -- 1
print(false or nil) -- nil
print(false or false) -- false
print(nil or "Hello world") -- 'Hello world'
print("Cookie" or nil) -- 'Cookie'
```
<!-- 접을 수 있는 라벨 -->
<details>
<summary>출력(output) > </summary>
<div markdown="1">

> Info : Lua 5.3.5<br/>
> 1<br/>
> nil<br/>
> false<br/>
> Hello world<br/>
> Cookie<br/>

</div>
</details>

그리고 and 와 비슷하게 앞의 값이 nil,false 이 아니라면<sup>[[참조1](#footnote_1)]</sup> 뒤에 값에는 접근도 하지 않습니다, 아래에 코드로 테스트 해볼 수 있습니다
```lua
local a = "Hello World"
local b -- local b = nil 이랑 같은 효과

print(a or b:get()) -- Hello World
-- b에는 get 이 없어서 오류가 나야하지만 앞에 a 가 nil,false 이 아니라 그냥 넘어갑니다
```

<!-- 접을 수 있는 라벨 -->
<details>
<summary>출력(output) > </summary>
<div markdown="1">

> Info : lua 5.3.5<br/>
> Hello World<br/>

</div>
</details>

---
### and 와 or 의 진짜 위력은 같이 사용할때 배가된다 <a name="a_and_b_or_c"></a>
오픈소스된 lua 코드들을 보면 `a and b or c` 같은 `and` 와 `or` 이 같이 사용되는 식을 본 적 있을껍니다 

그리고 그 `a and b or c` 식으로 쓰여진걸 간단히 '삼항연산자' 라고 부릅니다 

이 삼항 연산자가 작동하는 방식은
`a and b or c` 에서 a 가 false(false,nil) 이라면 c 를 반환하고 그렇지 않다면 b 를 반환하게 됩니다 

간단히 a 에 값에 따라서 b 를 줄지 c 를 줄지 결정 하는것 입니다
예제 코드를 실행해보면 바로 알 수 있습니다
```lua
print(true and "Hello" or "Hi") -- 'Hello'
print(false and "Hello" or "Hi") -- 'Hi'
```
<!-- 접을 수 있는 라벨 -->
<details>
<summary>출력(output) > </summary>
<div markdown="1">

> Info : Lua 5.3.5<br/>
> Hello<br/>
> Hi<br/>

</div>
</details>

이 방법은 if 를 극단적으로 줄여주고(코드의 줄이 줄어듬) 코드를 깔끔하게 해주기 때문에 많이 사용됩니다 

활용 예시로써 마우스를 얻는데 플러그인, 인게임 둘다 작동 할 수 있어야 된다면 다음과 같이 코드를 짤 수 있습니다

<!-- 아래 코드는 바꿀 필요가 있습니다. -->
<!-- 이것은 순수 lua 에서 작동하지 않으며 -->
<!-- Roblox lua 를 위한것 입니다 -->
```lua
-- 삼항 연산자를 사용한 코드, 3줄
local LocalPlayer = game.Players.LocalPlayer
local LocalMouse = LocalPlayer and LocalPlayer:GetMouse()
local Mosue = plugin and plugin:GetMouse() or LocalMouse 

-- if 를 사용한 코드, 7줄
local Player = game.Players.LocalPlayer
local Mosue
if Player then
   Mosue = Player:GetMouse()
elseif plugin then
   Mouse = plugin:GetMouse()
end
```

---
### 연속된 논리 연산자들 <a name="chain_and_or"></a>
```lua
a and b and c or d and f
```
위와 같은식으로 길게 길게 써져 있는 연산자는 어떻게 해석해야 될까요? <s>저러지 마세요, 읽기 엄청 힘들어 집니다</s>

그냥 수학에서 1 + 2 + 3 처럼 앞에서 순서대로 읽어주면 됩니다
먼저 맨 앞에 있는 1 + 2 를 해주고 그 다음 (앞에 더한거) + 3 하듯
앞에 a and b 구하고 그 다음 (이전 결과) and c ... 이런식으로 가게 됩니다
괄호가 있는 경우도 수학에서 처럼 괄호를 먼저 계산 해주면 됩니다 

예시 :
```lua
print(true and "abc" or true or false)
```
<!-- 접을 수 있는 라벨 -->
<details>
<summary>출력(output) > </summary>
<div markdown="1">

> Info : Lua 5.3.5<br/>
> abc<br/>

</div>
</details>

---
<!-- 각주 부분 -->
 <a name="footnote_1">[참조1]</a> : lua 에서는 nil 과 false 을 제외한 모든것(0 을 포함한 모든 숫자,문자열,테이블,유저데이터(Instance...),true, 등등) 을 true 처럼 취급합니다.
