using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyBanHang
{
    
    public partial class Form1 : Form
    {
        private DataProvider dataProvider = new DataProvider();
        private int maSachLoaiSach;
        private int maSachSach;
        private int maLoaiSachLoaiSach;

        public Form1()
        {
            InitializeComponent();
            init();
        }
        private void init()
        {
            initSach();
            initLoaiSach();
           
        }
       
        private void initSach() //muốn chạy được thì thêm tên hàm vào đây ví dụ: loadcbSachLoaiSach();
        {
            loadDgSach();
            loadcbSachLoaiSach();
            
        }
        //hàm để load lại dữ liệu ví dụ thêm loại sách thì bên loại sách của sách sẽ load lại 
      
        //sach 
        private void loadDgSach()
        {
            DataTable dt = new DataTable();
            //chuyển sang tên cho người dùng thay vì hiển thị ma_sach,ten_sach...
            StringBuilder query = new StringBuilder("SELECT ma_sach as [Mã Sách]");
            query.Append(",ten_sach as [Tên Sách]");
            query.Append(",ten_loai_sach as [Loại Sách]");
            query.Append(",tac_gia as [Tác Giả]");
            query.Append(",so_luong as [Số Lượng]");
            query.Append(",gia_ban as [Giá Bán]");
            query.Append(" FROM tbl_sach, tbl_loai_sach");
            query.Append(" WHERE tbl_sach.ma_loai_sach = tbl_loai_sach.ma_loai_sach;");

            dt=dataProvider.execQuery(query.ToString());

            dgSach.DataSource = dt;
        }
        private void loadcbSachLoaiSach()
        {
            DataTable dt=new DataTable();
            //lấy dữ liệu để hiẻne thị xuống combox(loại Sách)
            dt = dataProvider.execQuery("SELECT * FROM tbl_loai_sach");
            cbSachLoaiSach.DisplayMember= "ten_loai_sach";//lấy tên loại sách
            cbSachLoaiSach.ValueMember = "ma_loai_sach";//để insert để vào CSDL theo mã sách
            cbSachLoaiSach.DataSource= dt;
        }
        //hàm để khi click vào thì sẽ hiển thị dữ liệu theo đúng font 
        private void dgSach_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int rowId=e.RowIndex;//khi click sẽ trả về cột bằng hàm khi cellclick

            if(rowId < 0) rowId = 0;//khi bấm vào ô troóng không có dữ liệu sẽ trả về cột 0 
            if (rowId == dgSach.RowCount - 1) rowId = rowId - 1;
            DataGridViewRow row = dgSach.Rows[rowId];
            maSachSach = (int)row.Cells[0].Value;
            txtSachTenSach.Text = row.Cells[1].Value.ToString();
            cbSachLoaiSach.Text= row.Cells[2].Value.ToString();
            txtSachTacGia.Text = row.Cells[3].Value.ToString();
            numSachSoLuong.Value = (int)row.Cells[4].Value;
            numSachGiaBan.Value =  Convert.ToInt32( row.Cells[5].Value);//chuyển đổi kiểu dưc diệu trong CSDL thành kiểu int

            maSachLoaiSach = (int)dataProvider.execScaler("SELECT ma_loai_sach FROM  tbl_loai_sach WHERE ten_loai_sach=N'" + cbSachLoaiSach.Text + "'");
        }

        private void btnSachThem_Click(object sender, EventArgs e)
        {
            // Kiểm tra dữ liệu đầu vào
            if (string.IsNullOrWhiteSpace(txtSachTenSach.Text))
            {
                MessageBox.Show("Vui lòng nhập tên sách!", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtSachTenSach.Focus();
                return;
            }
            if (cbSachLoaiSach.SelectedIndex == -1) // Kiểm tra chưa chọn loại sách
            {
                MessageBox.Show("Vui lòng chọn loại sách!", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cbSachLoaiSach.Focus();
                return;
            }
            if (string.IsNullOrWhiteSpace(txtSachTacGia.Text))
            {
                MessageBox.Show("Vui lòng nhập tác giả!", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtSachTacGia.Focus();
                return;
            }
            if (numSachSoLuong.Value <= 0)
            {
                MessageBox.Show("Số lượng phải lớn hơn 0!", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                numSachSoLuong.Focus();
                return;
            }
            if (numSachGiaBan.Value <= 0)
            {
                MessageBox.Show("Giá bán phải lớn hơn 0!", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                numSachGiaBan.Focus();
                return;
            }

            // Xây dựng câu truy vấn
            StringBuilder query = new StringBuilder("EXEC sp_insert_sach ");
            query.Append("@ten_sach = N'" + txtSachTenSach.Text + "', ");
            query.Append("@ma_loai_sach = " + maSachLoaiSach + ", ");
            query.Append("@tac_gia = N'" + txtSachTacGia.Text + "', ");
            query.Append("@so_luong = " + numSachSoLuong.Value + ", ");
            query.Append("@gia_ban = " + numSachGiaBan.Value);

            // Thực thi truy vấn
            int result = dataProvider.execNonQuery(query.ToString());
            if (result > 0)
            {
                loadDgSach();
                MessageBox.Show("Thêm sách thành công!", "Thành công", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("Thêm sách không thành công!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }



        private void btnSachSua_Click(object sender, EventArgs e)
        {
            StringBuilder query = new StringBuilder("EXEC sp_update_sach ");
            query.Append("@ma_sach = " + maSachSach + ", ");
            query.Append("@ten_sach = N'" + txtSachTenSach.Text + "', ");
            query.Append("@ma_loai_sach = " + maSachLoaiSach + ", ");
            query.Append("@tac_gia = N'" + txtSachTacGia.Text + "', ");
            query.Append("@so_luong = " + numSachSoLuong.Value + ", ");
            query.Append("@gia_ban = " + numSachGiaBan.Value);

            int result = dataProvider.execNonQuery(query.ToString());
            if (result > 0)
            {
                loadDgSach();
                MessageBox.Show("Cập nhập sách thành công!", "Thành công", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("Cập nhập không thành công!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnSachXoa_Click(object sender, EventArgs e)
        {
           DialogResult check= MessageBox.Show("Bạn có chắc chắn muốn xóa sách" + txtSachTenSach.Text + "?", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if(check == DialogResult.Yes)
            {
                string query = "DELETE FROM tbl_sach WHERE ma_sach=" + maSachSach;
                int result = dataProvider.execNonQuery(query.ToString());
                if (result > 0)
                {
                    loadDgSach();
                    MessageBox.Show("Xóa sách thành công!", "Thành công", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
                }
                else
                {
                    MessageBox.Show("Xóa sách không thành công!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }    
        }

        private void cbSachLoaiSach_SelectedIndexChanged(object sender, EventArgs e)
        {
            ComboBox comboBox=sender as ComboBox;
            maSachLoaiSach =(int)comboBox.SelectedValue;//để thực hiện để lấy được tên loai sách để insert
        }
        //loại sách 
        private void initLoaiSach()
        {
            loadDgLoaiSach();
        }
        private void loadDgLoaiSach()
        {
            DataTable dt = new DataTable();
            //chuyển sang tên cho người dùng thay vì hiển thị ma_sach,ten_sach...
            StringBuilder query = new StringBuilder("SELECT ma_loai_sach as [Mã Loại Sách], ");
            query.Append("ten_loai_sach as [Tên Loại Sách] ");
            query.Append("FROM tbl_loai_sach");

            dt = dataProvider.execQuery(query.ToString());
            dgLoaiSach.DataSource= dt;
        }

        private void dgLoaiSach_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int rowId = e.RowIndex;//khi click sẽ trả về cột bằng hàm khi cellclick

            if (rowId < 0) rowId = 0;//khi bấm vào ô troóng không có dữ liệu sẽ trả về cột 0 
            if (rowId == dgLoaiSach.RowCount - 1) rowId = rowId - 1;
            DataGridViewRow row = dgLoaiSach.Rows[rowId];
            maLoaiSachLoaiSach = (int)row.Cells[0].Value;
            txtLoaiSachTenLoaiSach.Text= row.Cells[1].Value.ToString();
        }

        private void btnLoaiSachThem_Click(object sender, EventArgs e)
        {
            StringBuilder query = new StringBuilder("EXEC sp_insert_loai_sach ");
            query.Append("@ten_loai_sach = N'" + txtLoaiSachTenLoaiSach .Text + "'");
           

            int result = dataProvider.execNonQuery(query.ToString());
            if (result > 0)
            {
                loadDgLoaiSach();
                loadcbSachLoaiSach();
                loadDgSach();
                MessageBox.Show("Thêm loại sách thành công!", "Thành công", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("Thêm loại sách không thành công!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnLoaiSachSua_Click(object sender, EventArgs e)
        {
            StringBuilder query = new StringBuilder("EXEC sp_update_loai_sach ");
            query.Append("@ten_loai_sach = N'" + txtLoaiSachTenLoaiSach.Text + "', ");
            query.Append("@ma_loai_sach = " + maLoaiSachLoaiSach);

            int result = dataProvider.execNonQuery(query.ToString());
            if (result > 0)
            {
                // Cập nhật lại dữ liệu
                loadDgLoaiSach();      // Load lại loại sách
                loadcbSachLoaiSach();  // Load lại combobox loại sách

                // Load lại danh sách sách để cập nhật thông tin loại sách mới sửa
                loadDgSach();

                MessageBox.Show("Cập nhật loại sách thành công!", "Thành công",
                                MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("Cập nhật loại sách không thành công!", "Lỗi",
                                MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }


        /*  private void btnLoaiSachXoa_Click(object sender, EventArgs e)
   {
       // Kiểm tra xem có sách nào thuộc loại sách này không
       string queryCheck = "SELECT COUNT(*) FROM tbl_sach WHERE ma_loai_sach = " + maLoaiSachLoaiSach;
       int bookCount = (int)dataProvider.execScaler(queryCheck);

       if (bookCount > 0)
       {
           MessageBox.Show("Không thể xóa! Vẫn còn sách thuộc loại này.", "Lỗi", 
                           MessageBoxButtons.OK, MessageBoxIcon.Error);
           return;
       }

       // Hỏi người dùng có chắc chắn muốn xóa
       DialogResult check = MessageBox.Show("Bạn có chắc chắn muốn xóa loại sách " + 
                           txtLoaiSachTenLoaiSach.Text + "?", "Cảnh báo", 
                           MessageBoxButtons.YesNo, MessageBoxIcon.Question);

       if (check == DialogResult.Yes)
       {
           string query = "DELETE FROM tbl_loai_sach WHERE ma_loai_sach = " + maLoaiSachLoaiSach;
           int result = dataProvider.execNonQuery(query);

           if (result > 0)
           {
               loadDgLoaiSach();
               loadcbSachLoaiSach();
               MessageBox.Show("Xóa loại sách thành công!", "Thành công", 
                               MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
           }
           else
           {
               MessageBox.Show("Xóa loại sách không thành công!", "Lỗi", 
                               MessageBoxButtons.OK, MessageBoxIcon.Error);
           }
       }
   }*/
        private void btnLoaiSachXoa_Click(object sender, EventArgs e)
        {
            DialogResult check = MessageBox.Show("Bạn có chắc chắn muốn xóa loại sách " +
                            txtLoaiSachTenLoaiSach.Text + " và tất cả sách liên quan?",
                            "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (check == DialogResult.Yes)
            {
                // Xóa tất cả sách thuộc loại sách này trước
                string queryDeleteBooks = "DELETE FROM tbl_sach WHERE ma_loai_sach = " + maLoaiSachLoaiSach;
                dataProvider.execNonQuery(queryDeleteBooks);

                // Xóa loại sách
                string query = "DELETE FROM tbl_loai_sach WHERE ma_loai_sach = " + maLoaiSachLoaiSach;
                int result = dataProvider.execNonQuery(query);

                if (result > 0)
                {
                    loadDgLoaiSach();
                    loadcbSachLoaiSach();
                    loadDgSach();  // Cập nhật lại danh sách sách
                    
                    MessageBox.Show("Xóa loại sách và sách liên quan thành công!", "Thành công",
                                    MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
                }
                else
                {
                    MessageBox.Show("Xóa loại sách không thành công!", "Lỗi",
                                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

     
       
    }
}
