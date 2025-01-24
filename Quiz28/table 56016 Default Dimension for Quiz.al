table 56016 "Default Dimension for Quiz"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "Quiz No."; Code[20]) { }
        field(56001; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            TableRelation = Dimension.Code;
        }
        field(56002; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"));
        }
    }

    keys
    {
        key(PK; "Quiz No.", "Dimension Code")
        {
            Clustered = true;
        }
    }
}