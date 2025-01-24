table 56015 "Inventory On Hand List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "No."; Integer) { }
        field(56001; "Item No."; Code[20]) { }
        field(56002; "Item Desc"; Text[100]) { }
        field(56003; "Location"; Code[10]) { }
        field(56004; "Current Qty"; Integer) { }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Sort; "Item No.", Location, "Current Qty") // 정렬 기준 설정
        {
            Clustered = false;
        }
    }
}