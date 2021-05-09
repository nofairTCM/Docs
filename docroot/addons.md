---
hide:
    - toc
---

여기는 그냥 플긴으로 추가된 md 문법을 보여주는 문서입니다

!!! quote "이런식으로 따옴 단락을 만듬"
    네칸씩 띄워서 안에 올 아이템들을 만듭니다,  
    들여쓰기가 끝나는 지점이 나올 때 까지 지속됩니다  

!!! note "이런식으로 노트쓰기"
    위와 비슷한 방식을 따릅니다,  
    "" 안을 비워두면 해더가 표시되지 않습니다  

???+ note "기본적으로 열려있는 축소 가능한 단락"
    앞에있는 note 를 원하는 아이콘으로 바꿀 수 있습니다

??? note "기본적으로 닫혀있는 축소 가능한 단락"
    위와 비슷하며 + 를 쓰지 않으면 기본적으로 닫힌 단락을 만들 수 있습니다

=== "탭1"

    네칸씩 띄워서 내부 아이템을 만듭니다  
    ```lua
    -- 테마 테스팅

    -- comment line
    function func(arg1)
        local str = "string"
        for i = 1,5 do
            print(string.rep("Hello World",i))
        end
        return {
            Text = str;
            Boolean = true;
            Null = nil;
        }
    end
    print(func())
    print(string)
    ```

=== "탭2"

    개속해서 쓰기가 가능합니다.  
    탭 구분마다 위아래로 라인 브레이킹도 있어야됩니다  

| 리스트 | 리스트 |
| -- | -- |
| 1 | 2 |