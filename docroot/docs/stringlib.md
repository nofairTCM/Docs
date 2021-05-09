---
title: 문자열 라이브러리
subtitle: 문자열 라이브러리
written_by: Qwreey
when_edited: 2021 2/1 4:10
---
{% include "headinfo.md" %}

## string.find(문자열,패턴,시작점,플레인) 

어떤 문자열에 대해서 패턴을 검색합니다  
문자열에서 가장 처음으로 찾은 패턴의 시작부분과 끝부분을 반환합니다  
만약 아무것도 찾지 못했다면 nil 을 반환합니다 

=== "인수"

    | no {: #table-custom style="width: 0.5em;"} | 인수 {: #table-custom style="width: 4.6em;"} | 설명 | 타입 {: #table-custom style="width: 4em;"} | 기본값 {: #table-custom style="width: 4.6em;"} |
    | -- | ---- | ---- | ---- | ------ |
    | 1 | 문자열 | 검색을 수행할 문자열 | string | ? |
    | 2 | 패턴 | 검색어 문자열 (찾을 문자) | string | ? |
    | 3 | 시작점 | 검색을 시작할 위치를 나타냅니다. 예를 들어 이 값이 5 라면 다섯번째 글자부터 검색을 시작합니다, 이 값을 음수로 지정하면 뒤에서부터 ~ 째 부터 검색을 하는 효과를 가집니다. 이 값을 비워두면 맨 앞에서부터 검색을 시작합니다 | 1 |
    | 4 | 플레인 | 이 값이 true 라면 특수 패턴 없이 검색을 시도합니다. 있는 그대로 검색을 하기 때문에 사용자 입력 값에 따라 검색을 수행할 때 유용합니다 | bool | false |

=== "반환"

    | no | 설명 | 타입 |
    | -- | ---- | ---- |
    | 1 | 문자열에서 패턴이 발견된 부분의 시작점입니다, 발견된것이 없다면 nil 을 반환합니다 | number 또는 nil |
    | 2 | 문자열에서 패턴이 발견된 부분의 끝점입니다, 발견된것이 없다면 nil 을 반환합니다 | number 또는 nil |


예제
```lua
-- 패턴 검색
local start,end = string.find("abcd 1234","%d")
print("가장 첫번째로 발견된 숫자의 위치는 " .. start .. " 입니다")

-- 플레인 검색
print(string.find("hello. lua",".",1,true))
-- 패턴에서의 . 이 아닌 그대로 . 을 검색합니다 

local start,end = string.find("abcd","bc")
print(start,end) -- 
```

