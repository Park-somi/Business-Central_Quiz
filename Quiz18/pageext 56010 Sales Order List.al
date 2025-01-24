pageextension 56010 SalesOrderList extends "Sales Order List"
{
    actions
    {
        // Post 버튼 수정
        modify(Post)
        {
            Visible = false;
            Enabled = false;
        }

        // 숨겨져 있는 버튼 보여주기
        addafter(PostAndSend_Promoted)
        {
            actionref(Post2_Show; "Post2") { }
        }

        // Post2 버튼 만들기
        addafter(PostAndSend)
        {
            action("Post2")
            {
                Caption = 'Post2';
                Image = Add;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesBatchPostMgt: Codeunit "Sales Batch Post Mgt.";
                    BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    if SalesHeader.Count > 1 then begin
                        BatchProcessingMgt.SetParametersForPageID(Page::"Sales Order List");

                        SalesBatchPostMgt.SetBatchProcessor(BatchProcessingMgt);
                        SalesBatchPostMgt.RunWithUI(SalesHeader, Rec.Count, ReadyToPostQst);
                    end else
                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)");
                end;
            }
        }
    }

    var
        ReadyToPostQst: Label 'The number of orders that will be posted is %1. \Do you want to continue?', Comment = '%1 - selected count';
}