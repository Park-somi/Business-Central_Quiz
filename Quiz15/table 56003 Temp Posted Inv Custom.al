table 56003 "Temp Posted Inv Custom"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "No."; Integer) { Caption = 'No.'; }
        field(56001; "Customer No."; Code[10]) { Caption = 'Customer No.'; }
        field(56002; "Customer Name"; Text[50]) { Caption = 'Customer Name'; }
        field(56003; "Currency Code"; Code[10]) { Caption = 'Currency Code'; }
        field(56004; "Item No."; Code[10]) { Caption = 'Item No.'; }
        field(56005; "Item Name"; Text[50]) { Caption = 'Item Name'; }
        field(56006; "Customer Contact"; Code[10]) { Caption = 'Customer Contact'; }
        field(56007; "Customer Contact Name"; Text[50]) { Caption = 'Customer Contact Name'; }
        field(56008; "Location"; Code[10]) { Caption = 'Location'; }
        field(56009; "Quantity"; Decimal) { Caption = 'Quantity'; }
        field(56010; "Unit Price"; Decimal) { Caption = 'Unit Price'; }
        field(56011; "Amount"; Decimal) { Caption = 'Amount'; }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}