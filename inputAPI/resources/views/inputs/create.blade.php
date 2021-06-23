<h1>Create Data Kendaraan</h1>

<form action="/inputs" method="POST">
    @csrf
    Nama_Kendaraan : <input type="text" name="nama_kendaraan"><br>
    Jenis_Kendaraan: <input type="text" name="jenis_kendaraan"><br>
    Harga_Sewa: <input type="number" name="harga_sewa"><br>
    Image_url:<input type="text" name="image_url"><br>
    <input type="submit" value="Upload">
</form>