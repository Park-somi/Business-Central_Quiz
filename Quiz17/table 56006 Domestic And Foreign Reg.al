table 56006 "Domestic And Foreign Reg"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Last Name", "First Name"; // Card Page에서 보여질 Title 필드 설정

    fields
    {
        field(56000; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(56001; "Nationality Type"; Option)
        {
            Caption = 'Nationality Type';
            OptionMembers = Domestic,Foreigner;
            InitValue = Domestic;
        }
        field(56002; "Last Name"; Code[50]) // 대소문자 구분 O
        {
            Caption = 'Last Name';
        }
        field(56003; "First Name"; Text[100]) // 대소문자 구분 X
        {
            Caption = 'First Name';
        }
        field(56004; "Country"; Code[10])
        {
            Caption = 'Country';
            TableRelation = Language.Code;
            InitValue = 'KOR';
        }
        field(56005; "Domestic Registration No."; Code[13])
        {
            Caption = 'Domestic Registration No.';
        }
        field(56006; "Foreigner Registration No."; Code[10])
        {
            Caption = 'Foreigner Registration No.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}