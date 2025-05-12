<!-- Thêm option Search vào navbar -->
<li class="nav-item">
  <a class="nav-link" href="#" data-toggle="modal" data-target="#searchModal">Search</a>
</li>

<!-- Thêm modal popup cho tìm kiếm -->
<div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="searchModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="searchModalLabel">Search Products</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="shop" method="GET">
          <div class="form-group">
            <input type="text" class="form-control" name="search" placeholder="Enter keyword...">
          </div>
          <button type="submit" class="btn btn-primary">Search</button>
        </form>
      </div>
    </div>
  </div>
</div> 