table 56005 "Bicycle Brand"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; Code; Code[10]) { Caption = 'Code'; }
        field(56001; Name; Text[30]) { Caption = 'Name'; }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    //필드 그룹 기본 구성
    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Name") { }
        fieldgroup(Brick; "Code", "Name") { }
    }

    trigger OnInsert()
    begin
        //Code 필드 빈값은 오류로 처리
        rec.TestField("Code");
    end;

    trigger OnModify()
    begin
        //Code 필드 빈값은 오류로 처리
        rec.TestField("Code");
    end;
}