/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.PurchaserProSpceDao;
import com.google.gson.Gson;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 999999999)
public class PurchaserProSpceBean extends HttpServlet {

    private String uploaded_file;
    private String project_Id;
    private String start_Date;
    private String end_Date;
    private String status;
    private String[] table_row;
    private String Id;
    private int userId;
    private int i;
    private int group_Id;
    private String supplier_Id;
    private String purchaser_Desc;
    private int tdc_Id;
    private boolean addPurchaserProSpce;
    private String pSpce;
    private String[] supplier;
    private Part part;
    private InputStream inputStream = null;
    private String photo;
    private File newFile;
    private String fileName;
    private OutputStream out1;
    private InputStream fileContent;

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");

        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            photo = "";
            uploaded_file = "E:/project/E-Tendering/web/allUpload";
            newFile = new File(uploaded_file);

            project_Id = request.getParameter("project_id");
            start_Date = request.getParameter("sDate");
            end_Date = request.getParameter("eDate");
            status = request.getParameter("status");

            table_row = request.getParameterValues("table_row[]");

            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            userId = Integer.parseInt(Id);

            for (i = 0; i < table_row.length; i++) {
                group_Id = Integer.parseInt(request.getParameter("group_id_" + table_row[i]));

                supplier = Arrays.toString(request.getParameterValues("selected_id_" + table_row[i] + "[]")).split("[\\[\\]]")[1].split(", ");
                List<String> myList = new ArrayList<>();
                myList.addAll(Arrays.asList(supplier));

                Gson gson = new Gson();
                supplier_Id = gson.toJson(supplier);

                if (request.getParameter("purc_text_" + table_row[i]) != null) {
                    purchaser_Desc = request.getParameter("purc_text_" + table_row[i]);
                    tdc_Id = Integer.parseInt(request.getParameter("tdc_text_1"));
                    addPurchaserProSpce = PurchaserProSpceDao.addPurchaseProSpec(project_Id, tdc_Id, purchaser_Desc, pSpce, supplier_Id, status, start_Date, end_Date, group_Id, userId);
                }

                if (request.getParameter("purc_number_" + table_row[i]) != null) {
                    purchaser_Desc = request.getParameter("purc_number_" + table_row[i]);
                    tdc_Id = Integer.parseInt(request.getParameter("tdc_number_1"));
                    addPurchaserProSpce = PurchaserProSpceDao.addPurchaseProSpec(project_Id, tdc_Id, purchaser_Desc, pSpce, supplier_Id, status, start_Date, end_Date, group_Id, userId);
                }

                if (request.getParameter("purc_textarea_" + table_row[i]) != null) {
                    purchaser_Desc = request.getParameter("purc_textarea_" + table_row[i]);
                    tdc_Id = Integer.parseInt(request.getParameter("tdc_textarea_1"));
                    addPurchaserProSpce = PurchaserProSpceDao.addPurchaseProSpec(project_Id, tdc_Id, purchaser_Desc, pSpce, supplier_Id, status, start_Date, end_Date, group_Id, userId);
                }

                if (request.getPart("purc_file_" + table_row[i]) != null) {
                    part = request.getPart("purc_file_" + table_row[i]);

                    fileName = getFileName(part);
                    newFile.mkdir();
                    out1 = null;
                    PrintWriter writer = response.getWriter();
                    out1 = new FileOutputStream(new File(uploaded_file + File.separator + fileName));
                    fileContent = part.getInputStream();
                    int read = 0;
                    final byte[] bytes = new byte[1024];
                    while((read = fileContent.read(bytes)) != -1){
                        out1.write(bytes, 0, read);
                    }
                    if (part != null) {
                        inputStream = part.getInputStream();
                    }
                    tdc_Id = Integer.parseInt(request.getParameter("tdc_file_1"));
                    addPurchaserProSpce = PurchaserProSpceDao.addPurchaseProSpec(project_Id, tdc_Id, fileName, pSpce, supplier_Id, status, start_Date, end_Date, group_Id, userId);
                }
            }
            
            if (addPurchaserProSpce) {
                String success = "<p class='alert-info'>Purchaser Specification Inserted Successfully</p>";
                request.getSession().setAttribute("addPurchaserProSpce", success);
                response.sendRedirect("purchaser/newTender.jsp");
            } else {
                String error = "<p class='alert-danger'>Error to Insert Purchaser Specification</p>";
                request.getSession().setAttribute("addPurchaserProSpce", error);
                response.sendRedirect("purchaser/newTender.jsp");
            }
            
        } catch (Exception ex) {
            Logger.getLogger(PurchaserProSpceBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
