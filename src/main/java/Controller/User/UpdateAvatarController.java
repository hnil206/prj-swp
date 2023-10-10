package Controller.User;

import Dao.UserDao;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100  // 100 MB
)

public class UpdateAvatarController extends HttpServlet {
    public String generateUniqueFileName(String originalFileName) {
        // Get the file extension from the original filename
        String extension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex >= 0 && dotIndex < originalFileName.length() - 1) {
            extension = originalFileName.substring(dotIndex + 1);
        }

        // Generate a random UUID as the unique part of the filename
        String uniquePart = UUID.randomUUID().toString();

        // Combine the unique part and file extension to create the unique filename
        String uniqueFileName = uniquePart + "." + extension;

        return uniqueFileName;
    }
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim()
                        .replace("\"", "");
            }
        }
        return null;
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = ((User) request.getSession().getAttribute("user")).getId();
        Part filePart = request.getPart("image");
        String fileName = getFileName(filePart);
        assert fileName != null;
        String newFileName = generateUniqueFileName(fileName);
        String uploadDir = request.getServletContext().getRealPath("/") + "uploads";
        Path filePath = Paths.get(uploadDir, newFileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        if (new UserDao().updateAvatar(id, "uploads/" + newFileName)){
            User user = (User) request.getSession().getAttribute("user");
            user.avatar = "uploads/" + newFileName;
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("session_mess", "success|Cập nhật thành công.");
        } else {
            request.getSession().setAttribute("session_mess", "error|Cập nhật thất bại.");
        }
        response.sendRedirect(request.getContextPath() + "/user/profile");
    }
}
