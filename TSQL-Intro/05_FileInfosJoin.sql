use dmsmin
go

select path, [name], ext, SizeInBytes/(1024*1024.0) as SizeInMB, heightInPix, widthInPix
from data.FileInfos join data.FotoFileInfos on data.FileInfos.file_id = data.FotoFileInfos.file_id
order by SizeInMb
