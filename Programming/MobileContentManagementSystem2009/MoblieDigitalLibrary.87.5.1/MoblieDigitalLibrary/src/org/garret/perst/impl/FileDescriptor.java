package org.garret.perst.impl;

public final class FileDescriptor {
    private RandomAccessFile file;
    
    FileDescriptor(RandomAccessFile file) { 
        this.file = file;
    }
    
    public void sync() throws java.io.IOException { 
        file.flush();
    }
}
 