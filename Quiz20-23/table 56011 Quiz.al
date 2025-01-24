table 56011 Quiz
{
    DataClassification = ToBeClassified;

    fields
    {
        field(56000; "Quiz No."; Code[20]) { }
        field(56001; "Quiz Name"; Text[20]) { }
        field(56002; "Status"; Option) { OptionMembers = Open,Released; InitValue = Open; }
        field(56003; "Dimension Set Id"; Integer) { }
    }

    keys
    {
        key(PK; "Quiz No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        QuizComment: Record "Quiz Comment";
    begin
        QuizComment.SetRange("Document No.", Rec."Quiz No.");
        if QuizComment.FindSet() then
            repeat
                QuizComment.Delete();
            until QuizComment.Next() = 0;
    end;
}