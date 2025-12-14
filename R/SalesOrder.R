
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' SalesOrderSelectServer()
SalesOrderSelectServer <- function(input,output,session, app_id, run_env = "PRD") {
  #获取参数
  text_SalesOrder=tsui::var_text('text_SalesOrder')


  #查询按钮

  shiny::observeEvent(input$btn_SalesOrder_view,{

    FSalesOrderID=text_SalesOrder()


    if(FSalesOrderID==''){

      tsui::pop_notice("Please Enter Sales Order")


    }else{
      erp_token = rdbepkg::dbConfig(FAppId = app_id, FType = "ERP", FRunEnv = run_env)
      data = mdlVMSalesOrderPkg::SalesOrder_select(erp_token =erp_token ,FSalesOrderID =FSalesOrderID )
      # 增加对英文界面展示的支持
      tsui::run_dataTable2(id ='SalesOrder_resultView' ,data =data,lang='en')

      tsui::run_download_xlsx(id = 'dl_SalesOrder',data = data,filename = 'SalesOrder.xlsx')


    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' SalesOrderServer()
SalesOrderServer <- function(input,output,session, app_id, run_env = "PRD") {
  SalesOrderSelectServer(input = input,output = output,session = session,app_id=app_id, run_env = run_env)


}
