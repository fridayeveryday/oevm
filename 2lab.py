import psutil
import win32api
import wmi
import platform
import subprocess
import sys

import os

def get_size(bytes, suffix="B"):
    """
    Scale bytes to its proper format
    e.g:
        1253656 => '1.20MB'
        1253656678 => '1.17GB'
    """
    factor = 1024
    for unit in ["", "K", "M", "G", "T", "P"]:
        if bytes < factor:
            return f"{bytes:.2f}{unit}{suffix}"
        bytes /= factor
def getInf():

    c = wmi.WMI()
    wql = "SELECT * FROM Win32_DiskDrive"
    for disk in c.query(wql):
        # print(disk.__getattr__("Caption"))
        print("Название диска:",disk.__getattr__("Caption") )
        print("Модель:",disk.__getattr__("Model") )
        print("Описание:",disk.__getattr__("Description") )
        print("Серийный номер:",disk.__getattr__("SerialNumber") )
        print("Размер:%.2f"%((int)(disk.__getattr__("Size"))/2**30),"Гб")
        print("Состояние:",disk.__getattr__("Status"))
        print("Количество секторов (всего):",disk.__getattr__("TotalSectors"))
        print("Количество треков (дорожек) (всего):",disk.__getattr__("TotalTracks"))
        print("--"*40)


if __name__ == '__main__':
    getInf()

    hdd = psutil.disk_usage('/')


    print("=" * 40, "Disk Information", "=" * 40)
    print("Partitions and Usage:")
    # get all disk partitions
    partitions = psutil.disk_partitions()
    for partition in partitions:
        print(f"=== Device: {partition.device} ===")
        print(f"  Mountpoint: {partition.mountpoint}")
        print(f"  File system type: {partition.fstype}")
        try:
            partition_usage = psutil.disk_usage(partition.mountpoint)
        except PermissionError:
            # this can be catched due to the disk that
            # isn't ready
            continue
        print(f"  Total Size: {get_size(partition_usage.total)}")
        print(f"  Used: {get_size(partition_usage.used)}")
        print(f"  Free: {get_size(partition_usage.free)}")
        print(f"  Percentage: {partition_usage.percent}%")

    # Memory Information
    print("=" * 40, "Memory Information", "=" * 40)
    # get the memory details
    svmem = psutil.virtual_memory()
    print(f"Total: {get_size(svmem.total)}")
    print(f"Available: {get_size(svmem.available)}")
    print(f"Used: {get_size(svmem.used)}")
    print(f"Percentage: {svmem.percent}%")
    print("=" * 20, "SWAP", "=" * 20)
    # get the swap memory details (if exists)
    swap = psutil.swap_memory()
    print(f"Total: {get_size(swap.total)}")
    print(f"Free: {get_size(swap.free)}")
    print(f"Used: {get_size(swap.used)}")
    print(f"Percentage: {swap.percent}%")


    # for volume in wmi.WMI().wmi_property():
    #     print(volume.Caption, "=>", volume.VolumeSerialNumber)


    win32api.GetVolumeInformation("C:\\")
    print(psutil.disk_partitions())
    print(psutil.disk_usage('/'))
    print(psutil.virtual_memory())
