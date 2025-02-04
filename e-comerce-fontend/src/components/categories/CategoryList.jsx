import React, { useState, useEffect } from 'react';
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  IconButton,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  MenuItem,
  Select,
  FormControl,
  InputLabel,
  Typography
} from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import { categoryService } from '../../services/categoryService';

const CategoryList = () => {
  const [categories, setCategories] = useState([]);
  const [open, setOpen] = useState(false);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [selectedCategory, setSelectedCategory] = useState(null);
  const [categoryToDelete, setCategoryToDelete] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    parentCategoryId: '',
    level: 0
  });

  useEffect(() => {
    loadCategories();
  }, []);

  const loadCategories = async () => {
    try {
      const data = await categoryService.getAllCategories();
      setCategories(data);
    } catch (error) {
      console.error('Lỗi khi tải danh mục:', error);
    }
  };

  const handleOpen = (category = null) => {
    console.log(category);
    if (category) {
      setFormData(category);
      setSelectedCategory(category);
    } else {
      setFormData({ name: '', parentCategoryId: '', level: 0 });
      setSelectedCategory(null);
    }
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
    setSelectedCategory(null);
  };

  const handleSubmit = async () => {
    try {
      // Xác định cấp độ dựa trên danh mục cha
      const parentCategory = categories.find(c => c.id === formData.parentCategoryId);
      const level = parentCategory ? parentCategory.level + 1 : 0;
      const updatedFormData = { ...formData, level };

      if (selectedCategory) {
        await categoryService.updateCategory(selectedCategory.id, updatedFormData);
      } else {
        await categoryService.createCategory(updatedFormData);
      }
      handleClose();
      loadCategories();
    } catch (error) {
      console.error('Lỗi khi lưu danh mục:', error);
    }
  };

  const handleDeleteClick = (category) => {
    setCategoryToDelete(category);
    setDeleteDialogOpen(true);
  };

  const handleDeleteConfirm = async () => {
    try {
      await categoryService.deleteCategory(categoryToDelete.id);
      setDeleteDialogOpen(false);
      setCategoryToDelete(null);
      loadCategories();
    } catch (error) {
      console.error('Lỗi khi xóa danh mục:', error);
    }
  };

  const handleDeleteCancel = () => {
    setDeleteDialogOpen(false);
    setCategoryToDelete(null);
  };

  // Lọc các danh mục cha có sẵn, không bao gồm danh mục hiện tại và các danh mục con
  const getAvailableParents = (currentId = null) => {
    return categories.filter(category => {
      if (currentId === category.id) return false;
      if (currentId) {
        // Không cho phép chọn danh mục con làm danh mục cha
        let parent = categories.find(c => c.id === category.parentCategoryId);
        while (parent) {
          if (parent.id === currentId) return false;
          parent = categories.find(c => c.id === parent.parentCategoryId);
        }
      }
      return true;
    });
  };

  return (
    <div>
      <Button
        variant="contained"
        color="primary"
        onClick={() => handleOpen()}
        style={{ marginBottom: '20px' }}
      >
        Thêm Mới Danh Mục
      </Button>

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>ID</TableCell>
              <TableCell>Tên</TableCell>
              <TableCell>Danh Mục Cha</TableCell>
              <TableCell>Cấp Độ</TableCell>
              <TableCell>Hành Động</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {categories.map((category) => (
              <TableRow key={category.id}>
                <TableCell>{category.id}</TableCell>
                <TableCell>{category.name}</TableCell>
                <TableCell>
                  {categories.find(c => c.id === category.parentCategoryId)?.name || '-'}
                </TableCell>
                <TableCell>{category.level}</TableCell>
                <TableCell>
                  <IconButton onClick={() => handleOpen(category)}>
                    <Edit />
                  </IconButton>
                  <IconButton onClick={() => handleDeleteClick(category)}>
                    <Delete />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      {/* Dialog Form cho Danh Mục */}
      <Dialog open={open} onClose={handleClose} maxWidth="sm" fullWidth>
        <DialogTitle>{selectedCategory ? 'Chỉnh Sửa Danh Mục' : 'Thêm Danh Mục'}</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            label="Tên"
            fullWidth
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
          />
          <FormControl fullWidth margin="dense">
            <InputLabel>Danh Mục Cha</InputLabel>
            <Select
              value={formData.parentCategoryId}
              onChange={(e) => setFormData({ ...formData, parentCategoryId: e.target.value })}
              label="Danh Mục Cha"
            >
              <MenuItem value="">
                <em>Không có</em>
              </MenuItem>
              {getAvailableParents(selectedCategory?.id).map((category) => (
                <MenuItem key={category.id} value={category.id}>
                  {category.name}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>Hủy</Button>
          <Button onClick={handleSubmit} color="primary">
            {selectedCategory ? 'Cập Nhật' : 'Tạo Mới'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Xác Nhận Xóa Dialog */}
      <Dialog open={deleteDialogOpen} onClose={handleDeleteCancel}>
        <DialogTitle>Xác Nhận Xóa</DialogTitle>
        <DialogContent>
          <Typography>
            Bạn có chắc chắn muốn xóa danh mục "{categoryToDelete?.name}" không?
            {categoryToDelete && categories.some(c => c.parentCategoryId === categoryToDelete.id) && (
              <span style={{ color: 'red', display: 'block', marginTop: '10px' }}>
                Cảnh báo: Danh mục này có các danh mục con sẽ bị xóa!
              </span>
            )}
          </Typography>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleDeleteCancel}>Hủy</Button>
          <Button onClick={handleDeleteConfirm} color="error">
            Xóa
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default CategoryList;
