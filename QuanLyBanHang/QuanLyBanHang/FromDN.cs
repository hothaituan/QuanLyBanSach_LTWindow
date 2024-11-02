using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data;
namespace QuanLyBanHang
{
    public partial class FromDN : Form
    {
        public FromDN()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            DataProvider dataProvider = new DataProvider();
            try
            {

                DataProvider dataProvider1 = new DataProvider();
                string tk = txtUser.Text;
                string mk = txtPass.Text;
                string sql = $"SELECT * FROM tbl_user WHERE Username = '{tk}' AND Password = '{mk}'";

                DataTable result = dataProvider1.execQuery(sql);

                if (result.Rows.Count > 0)
                {
                   
                    this.Hide(); // Ẩn form đăng nhập
                    Form1 frm = new Form1(); // Khởi tạo form mới
                    frm.Show(); // Hiển thị form mới
                }
                else
                {
                    MessageBox.Show("Đăng nhập không thành công");
                }
            }
            catch(Exception ex) {
                MessageBox.Show("Lỗi kết nối: " + ex.Message);
            }
          
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            txtPass.UseSystemPasswordChar = !checkBox1.Checked;
        }

        private void FromDN_Load(object sender, EventArgs e)
        {

        }
    }
}
