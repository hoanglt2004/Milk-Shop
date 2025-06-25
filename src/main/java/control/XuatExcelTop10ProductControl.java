/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Product;
import entity.SoLuongDaBan;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "XuatExcelTop10ProductControl", urlPatterns = {"/xuatExcelTop10ProductControl"})
public class XuatExcelTop10ProductControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=top-10-san-pham-ban-chay.xlsx");

        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            XSSFSheet sheet = workbook.createSheet("Top 10 sản phẩm bán chạy");
            
            // Create header style
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            
            // Create header row
            XSSFRow headerRow = sheet.createRow(0);
            String[] headers = {"ID", "Tên sản phẩm", "Hình ảnh", "Giá", "Tiêu đề", "Mô tả", "Model", "Màu sắc", "Vận chuyển", "Hình ảnh 2", "Hình ảnh 3", "Số lượng đã bán"};
            
            for (int i = 0; i < headers.length; i++) {
                XSSFCell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
                sheet.autoSizeColumn(i);
            }

            // Get data from database
            DAO dao = new DAO();
            List<Product> listAllProduct = dao.getAllProduct();
            List<SoLuongDaBan> listTop10Product = dao.getTop10SanPhamBanChay();

            // Fill data rows
            int rowNum = 1;
            for (SoLuongDaBan soluong : listTop10Product) {
                for (Product pro : listAllProduct) {
                    if (soluong.getProductID() == pro.getId()) {
                        XSSFRow row = sheet.createRow(rowNum++);
                        row.createCell(0).setCellValue(pro.getId());
                        row.createCell(1).setCellValue(pro.getName());
                        row.createCell(2).setCellValue(pro.getImage());
                        row.createCell(3).setCellValue(pro.getPrice());
                        row.createCell(4).setCellValue(pro.getTitle());
                        row.createCell(5).setCellValue(pro.getDescription());
                        row.createCell(6).setCellValue(pro.getModel());
                        row.createCell(7).setCellValue(pro.getColor());
                        row.createCell(8).setCellValue(pro.getDelivery());
                        row.createCell(9).setCellValue(pro.getImage2());
                        row.createCell(10).setCellValue(pro.getImage3());
                        row.createCell(11).setCellValue(soluong.getSoLuongDaBan());
                    }
                }
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Write to response output stream
            workbook.write(response.getOutputStream());
        } catch (Exception e) {
            response.getWriter().println("Error exporting Excel: " + e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
