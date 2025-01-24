table 56003 "Temp Posted Inv Custom"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "No."; Integer) { }
        field(56001; "Customer No."; Code[10]) { }
        field(56002; "Customer Name"; Text[50]) { }
        field(56003; "Currency Code"; Code[10]) { }
        field(56004; "Item No."; Code[10]) { }
        field(56005; "Item Name"; Text[50]) { }
        field(56006; "Customer Contact"; Code[10]) { }
        field(56007; "Customer Contact Name"; Text[50]) { }
        field(56008; "Location"; Code[10]) { }
        field(56009; "Quantity"; Decimal) { }
        field(56010; "Unit Price"; Decimal) { }
        field(56011; "Amount"; Decimal) { }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}