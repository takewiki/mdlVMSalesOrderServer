
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' SalesOrderSelectServer()
SalesOrderSelectServer <- function(input,output,session,dms_token) {
  #获取参数
  text_SalesOrder=tsui::var_text('text_SalesOrder')


  #查询按钮

  shiny::observeEvent(input$btn_SalesOrder_view,{

    FSalesOrderID=text_SalesOrder()


    if(FSalesOrderID==''){

      tsui::pop_notice("Please Enter Sales Order")


    }else{
      data = mdlVMSalesOrderPkg::SalesOrder_select(erp_token =erp_token ,FSalesOrderID =FSalesOrderID )
      tsui::run_dataTable2(id ='SalesOrder_resultView' ,data =data )

      tsui::run_download_xlsx(id = 'dl_SalesOrder',data = data,filename = 'SalesOrder.xlsx')


    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' SalesOrderServer()
SalesOrderServer <- function(input,output,session,dms_token) {
  SalesOrderSelectServer(input = input,output = output,session = session,dms_token = dms_token)


}
