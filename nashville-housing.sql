Select *
From PortfolioProject.dbo.[Nashville Housing]

Select SaleDateConverted, CONVERT(Date,SaleDate)
From PortfolioProject.dbo.[Nashville Housing]

UPDATE [Nashville Housing]
SET SaleDateConverted= CONVERT(Date, SaleDate)


Select PropertyAddress
From PortfolioProject.dbo.[Nashville Housing]
 --Where PropertyAddress is null
 order by ParcelID

 -- Where PropertyAdress is null

 Select a.ParcelID,a.PropertyAddress,b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
 From PortfolioProject.dbo.[Nashville Housing] a
 JOIN PortfolioProject.dbo.[Nashville Housing] b
      on a.ParcelID= b.ParcelID
	    AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a 
SET PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.[Nashville Housing] a
JOIN PortfolioProject.dbo.[Nashville Housing] b
   on a.ParcelID=b.ParcelID
     AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null	 

-- Breaking out Address into Individuals Columns(Address,City,State)

Select PropertyAddress
From PortfolioProject.dbo.[Nashville Housing]
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From PortfolioProject.dbo.[Nashville Housing]


ALTER TABLE [Nashville Housing]
Add PropertySplitAddress Nvarchar(255);
 
Update [Nashville Housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE [Nashville Housing]
Add PropertySplitCity Nvarchar(255);

Update [Nashville Housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




Select *
From PortfolioProject.dbo.[Nashville Housing]





Select OwnerAddress
From PortfolioProject.dbo.[Nashville Housing]


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProject.dbo.[Nashville Housing]



ALTER TABLE [Nashville Housing]
Add OwnerSplitAddress Nvarchar(255);

Update [Nashville Housing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE [Nashville Housing]
Add OwnerSplitCity Nvarchar(255);

Update [Nashville Housing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE [Nashville Housing]
Add OwnerSplitState Nvarchar(255);

Update [Nashville Housing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From PortfolioProject.dbo.[Nashville Housing]


--Change Y and N to Yes and No in 'Sold as Vacant'

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.dbo.[Nashville Housing]
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant= 'Y' THEN 'YES'
       When SoldAsVacant= 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
FROM PortfolioProject.dbo.[Nashville Housing]

Update [Nashville Housing]
SET SoldAsVacant=CASE When SoldAsVacant='Y' THEN 'YES'
  WHEN SoldAsVacant='N' THEN 'NO'
  ELSE SoldAsVacant
  END

--Remove Duplicates
With RowNumCTE AS(
Select *,
        ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
		                     PropertyAddress,
							 SalePrice,
							 SaleDate,
							 LegalReference
							 ORDER BY 
							        UniqueID
									)row_num
From PortfolioProject.dbo.[Nashville Housing]

)
Select * 
From RowNumCTE
Where row_num>1
Order by PropertyAddress

Select *
From PortfolioProject.dbo.[Nashville Housing]

--Delete Unused Columns

Select *
From PortfolioProject.dbo.[Nashville Housing]

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate