import React, { useState } from "react";
import {
  Box,
  Typography,
  TextField,
  Button,
  Grid,
  Container,
  CircularProgress,
  Snackbar,
} from "@mui/material";
import { useSelector, useDispatch } from "react-redux";
import { updateUserInfo } from "../../../../app/UserSlice";
import { userService } from "../../../../services/userService";

const AccountProfile = () => {
  const dispatch = useDispatch();
  const user = useSelector((state) => state.user.userInfo);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState("");

  const [formData, setFormData] = useState({
    fullName: user?.fullName || "",
    email: user?.email || "",
    userName: user?.userName || "",
    password: "",
    mobile: user?.mobile || "",
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
    setError(null);
  };

  const validateForm = () => {
    if (!formData.fullName) {
      return "Họ và tên không được để trống.";
    }
    if (!formData.userName) {
      return "Tên đăng nhập không được để trống.";
    }
    return null;
  };

  const handleSaveChanges = async () => {
    const validationError = validateForm();
    if (validationError) {
    
      setSnackbarMessage(validationError);
      setSnackbarOpen(true);
      return;
    }

    const changedFields = {};
    Object.keys(formData).forEach((key) => {
      if (formData[key] !== user?.[key] && formData[key] !== "") {
        changedFields[key] = formData[key];
      }
    });

    if (Object.keys(changedFields).length > 0) {
      setIsLoading(true);
      setError(null);

      try {
        const updatedUser = await userService.updateUser(user.id, changedFields);
        //dispatch(updateUserInfo(updatedUser));
        console.log(updatedUser);
        setSnackbarMessage("Cập nhật hồ sơ thành công.");
        setSnackbarOpen(true);
      } catch (err) {
        setSnackbarMessage(err.response?.data?.message || "Không thể cập nhật hồ sơ");
        setSnackbarOpen(true);
        console.error("Error updating profile:", err);
      } finally {
        setIsLoading(false);
      }
    }
  };

  const handleSnackbarClose = () => {
    setSnackbarOpen(false);
  };

  return (
    <Container>
      <Box p={3}>
        <Typography variant="h4" gutterBottom style={{paddingBottom: '15px'}}>
        Thông tin tài khoản
        </Typography>
        {/* <Typography variant="subtitle1" gutterBottom padding={1}>
          Thông tin tài khoản
        </Typography> */}

        <Grid container spacing={3}>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Họ và tên"
              name="fullName"
              value={formData.fullName}
              onChange={handleInputChange}
              variant="outlined"
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              variant="outlined"
              disabled
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Tên đăng nhập"
              name="userName"
              value={formData.userName}
              onChange={handleInputChange}
              variant="outlined"
            />
          </Grid>
          {/* <Grid item xs={6}>
            <TextField
              fullWidth
              label="Mật khẩu"
              name="password"
              type="password"
              value={formData.password}
              onChange={handleInputChange}
              variant="outlined"
              placeholder="Nhập mật khẩu mới nếu muốn thay đổi"
            />
          </Grid> */}
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Số điện thoại"
              name="mobile"
              value={formData.mobile}
              onChange={handleInputChange}
              variant="outlined"
            />
          </Grid>

          <Grid item xs={12}>
            <Button
              variant="contained"
              color="primary"
              onClick={handleSaveChanges}
              disabled={isLoading}
              style={{display: 'none'}}
            >
              {isLoading ? <CircularProgress size={24} /> : "Lưu thay đổi"}
            </Button>
          </Grid>
        </Grid>
      </Box>

      {/* Snackbar for error or success messages */}
      <Snackbar
        open={snackbarOpen}
        autoHideDuration={6000}
        onClose={handleSnackbarClose}
        message={snackbarMessage}
      />
    </Container>
  );
};

export default AccountProfile;
