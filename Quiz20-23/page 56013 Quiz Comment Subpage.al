page 56013 "Quiz Comment Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Quiz Comment";
    Caption = 'Quiz Comment';
    DelayedInsert = true; // Validate 먼저 실행 후 insert. false인 경우, 빈 레코드 DB에 저장 후 Validate
    AutoSplitKey = true; // Comment 사이에 새로운 Comment 추가 시, 자동으로 Comment No. 분할 -> 추가한 위치에 새로운 Comment 추가

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

                    // TestField 함수
                    // (1) 단순 비어있지 않음 체크
                    // TestField("Field Name");

                    // (2) 특정 값과 일치 체크
                    // TestField("Status", Status::Open);

                    // (3) 커스텀 에러 메시지
                    // TestField("Field Name", '', '필드가 비어있으면 안됩니다.');
                }
            }
        }
    }
}