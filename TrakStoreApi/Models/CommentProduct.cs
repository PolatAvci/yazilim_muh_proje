namespace TrakStoreApi.Models
{
    public class CommentProduct
    {
        public int ProductId { get; set; }
        public Product Product { get; set; }

        public int CommentId { get; set; }
        public Comment Comment { get; set; }
    }
}
