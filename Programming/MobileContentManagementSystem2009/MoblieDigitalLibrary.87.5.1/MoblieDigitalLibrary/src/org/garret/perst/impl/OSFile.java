package org.garret.perst.impl;
import  org.garret.perst.*;
import java.io.*;

public class OSFile implements IFile {
    protected RandomAccessFile  file;
    protected boolean          noFlush;
    public void write(long pos, byte[] buf)
    {
        try {
            file.seek(pos);
            file.write(buf, 0, buf.length);
        } catch(IOException x) {
            throw new StorageError(StorageError.FILE_ACCESS_ERROR, x);
        }
    }

    public int read(long pos, byte[] buf)
    {
        try {
            file.seek(pos);
            return file.read(buf, 0, buf.length);
        } catch(IOException x) {
            throw new StorageError(StorageError.FILE_ACCESS_ERROR, x);
        }
    }

    public void sync()
    {
        if (!noFlush) {
            try {
                file.getFD().sync();
            } catch(IOException x) {
                throw new StorageError(StorageError.FILE_ACCESS_ERROR, x);
            }
        }
    }

    public void close()
    {
        try {
            file.close();
        } catch(IOException x) {
            throw new StorageError(StorageError.FILE_ACCESS_ERROR, x);
        }
    }

    public OSFile(String filePath, boolean readOnly, boolean noFlush) {
        this.noFlush = noFlush;
        try {
            file = new RandomAccessFile(filePath, readOnly ? "r" : "rw");
        } catch(IOException x) {
            throw new StorageError(StorageError.FILE_ACCESS_ERROR, x);
        }
    }

    public long length() {
        try {
            return file.length();
        } catch (IOException x) {
            return -1;
        }
    }
}
