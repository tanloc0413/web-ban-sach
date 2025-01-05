import React from 'react';
import { Box, Button, Typography } from '@mui/material';
import ReportIcon from '@mui/icons-material/Report';

const PaymentError = ({ error, onBackHome }) => {
  return (
    <Box sx={{ textAlign: 'center' }}>
      <ReportIcon sx={{ fontSize: "56px", color: "#ef4444" }} />
      <h3>PAYMENT FAILED</h3>
      <Typography>{error || 'Đã có lỗi trong quá trình thanh toán'}</Typography>
      <Button onClick={onBackHome} variant="contained" sx={{ mt: 2 }}>
        Quay về trang chủ
      </Button>
    </Box>
  );
};

export default PaymentError;