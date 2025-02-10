tableextension 56009 Item extends "Item"
{
    fields
    {
        field(56000; "Item Type"; Option)
        {
            Caption = 'Item Type', comment = '품목 유형';
            OptionMembers = None,Vehicle,Bicycle;

            // Item Type이 변경되면 Brand Code를 초기화
            trigger OnValidate()
            begin
                if xRec."Item Type" <> Rec."Item Type" then
                    "Brand Code" := '';
            end;
        }
        field(56001; "Brand Code"; Code[10])
        {
            Caption = 'Brand Code';

            TableRelation =
            if ("Item Type" = const(Vehicle)) "Vehicle Brand".Code
            else if ("Item Type" = const(Bicycle)) "Bicycle Brand".Code;
        }
    }
}