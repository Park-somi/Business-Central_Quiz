page 56013 "Quiz Comment Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Quiz Comment";
    Caption = 'Comment';
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Comment"; Rec.Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    // Status가 Open인 경우, '수정' 불가
                    trigger OnValidate()
                    var
                        Quiz: Record Quiz;
                    begin
                        Quiz.Reset();
                        if Quiz.Get(Rec."Document No.") then
                            Quiz.TestField(Status, Quiz.Status::Open);
                    end;
                }
            }
        }
    }

    // Status가 Open인 경우, '추가' 불가
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Quiz: Record Quiz;
        PrevLineNo: Integer;
        NextLineNo: Integer;
    begin
        Quiz.Reset();
        if Quiz.Get(Rec."Document No.") then
            Quiz.TestField(Status, Quiz.Status::Open);
    end;

    // Status가 Open인 경우, '삭제' 불가
    trigger OnDeleteRecord(): Boolean
    var
        Quiz: Record Quiz;
    begin
        Quiz.Reset();
        if Quiz.Get(Rec."Document No.") then
            Quiz.TestField(Status, Quiz.Status::Open);
    end;
}