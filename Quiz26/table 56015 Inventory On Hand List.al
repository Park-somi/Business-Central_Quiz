table 56015 "Inventory On Hand List"
{
    Caption = 'Inventory On Hand List';
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(56001; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(56002; "Item Desc"; Text[100])
        {
            Caption = 'Item Desc';
        }
        field(56003; "Location"; Code[10])
        {
            Caption = 'Location';
        }
        field(56004; "Current Qty"; Integer)
        {
            Caption = 'Current Qty';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Sort; "Item No.", Location, "Current Qty") // 정렬 기준 설정
        {
        }
    }
}