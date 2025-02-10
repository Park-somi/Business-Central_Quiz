table 56008 "Multiple Customers"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(56001; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(56002; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            TableRelation = Customer.Name;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}